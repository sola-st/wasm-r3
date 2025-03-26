import time, subprocess, json, os, concurrent, sys
import concurrent.futures
import util
import logging
from logging.handlers import RotatingFileHandler

TIMEOUT = 3600 * 24
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
EVAL_PATH = os.path.join(WASMR3_PATH, 'evaluation')
MAX_WORKER = int(os.getenv("MAX_WORKER", 1))
BINARYEN_CORES = int(os.getenv("BINARYEN_CORES", 1))


# Set up logging to file
current_date = time.strftime("%y%m%d")
current_time = time.strftime("%H%M%S")
log_dir = os.path.join(WASMR3_PATH, "evaluation", "logs", current_date, current_time)
os.makedirs(log_dir, exist_ok=True)

entry_logger = logging.getLogger('entry_logger')
entry_logger.setLevel(logging.INFO)
log_file = os.path.join(log_dir, "entry.log")
file_handler = RotatingFileHandler(log_file, maxBytes=50*1024*1024)
file_handler.setLevel(logging.INFO)
file_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
entry_logger.addHandler(file_handler)

def setup_individual_logger(testname, tool):
    individual_log_file = os.path.join(log_dir, f"{testname}-{tool}.log")
    individual_handler = RotatingFileHandler(individual_log_file, maxBytes=50*1024*1024, backupCount=20)
    individual_handler.setLevel(logging.INFO)
    individual_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
    individual_logger = logging.getLogger(f"{testname}-{tool}")
    individual_logger.setLevel(logging.INFO)
    individual_logger.addHandler(individual_handler)
    return individual_logger

# Exit if BINARYEN_ROOT is not set
if "BINARYEN_ROOT" not in os.environ:
    entry_logger.error("Error: BINARYEN_ROOT environment variable is not set")
    entry_logger.error(
        "https://github.com/WebAssembly/binaryen/blob/871ff0d4f910b565c15f82e8f3c9aa769b01d286/src/support/path.cpp#L95"
    )
    sys.exit(1)

valid_tests = util.start_metrics.keys()
valid_tools = util.tool_to_suffix.keys()
if len(sys.argv) < 3 or sys.argv[1] not in list(valid_tests) + ["all"] or sys.argv[2] not in list(valid_tools) + ["all"]:
    entry_logger.error("Usage: python eval_reduce [<test>|all] [<tool>|all]")
    sys.exit(1)

metrics = util.load_metrics(f'{EVAL_PATH}/metrics.json')
test_choice = sys.argv[1]
tool_choice = sys.argv[2]
if test_choice == "all":
    prioritize = ['bullet', 'wamr#2789', 'wamr#2862', 'sandspiel', 'commanderkeen']
    testset =  prioritize + [test for test in valid_tests if test not in prioritize]
else:
    testset = [test_choice]

if tool_choice == "all":
    toolset = valid_tools
else:
    toolset = [tool_choice]

entry_logger.info(f"MAX_WORKER: {MAX_WORKER}")
entry_logger.info(f"BINARYEN_CORES: {BINARYEN_CORES}")
entry_logger.info(f"len(testset): {len(testset)}")
entry_logger.info(f'testset: {testset}')
entry_logger.info(f"len(toolset): {len(toolset)}")
entry_logger.info(f'toolset: {toolset}')

def tool_to_command(tool, test_input, oracle_script):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    if tool == "wasm-reduce":
        test_path = (
            f"{EVAL_PATH}/benchmarks/{test_name}/{test_name}.reduced_test.wasm"
        )
        work_path = f"{EVAL_PATH}/benchmarks/{test_name}/{test_name}.reduced.wasm"
        return f"timeout {TIMEOUT}s {WASMR3_PATH}/third_party/binaryen/bin/wasm-reduce -to 60 -b $BINARYEN_ROOT/bin '--command=python {oracle_script} {test_path}' -t {test_path} -w {work_path} {test_input}"
    elif (
        tool == "wasm-shrink"
    ):  # https://github.com/doehyunbaek/wasm-tools/commit/5a9e4470f7023e08405d1d1e4e1fac0069680af1
        return f"timeout {TIMEOUT}s {WASMR3_PATH}/third_party/wasm-tools/target/release/wasm-tools shrink {oracle_script} {test_input}"
    elif tool == "wasm-slice":
        # Takes about 3 hours in lenovo
        return f"PRINT=1 timeout {TIMEOUT}s {WASMR3_PATH}/rr-reduce/wasm-slice {oracle_script} {test_input}"
    elif tool == "wasm-hybrid":
        # takes full 24 hours
        return f"PRINT=1 timeout {TIMEOUT}s {WASMR3_PATH}/rr-reduce/wasm-hybrid {oracle_script} {test_input}"
    else:
        exit("not supported")


def run_reduction_tool(testname, tool):
    individual_logger = setup_individual_logger(testname, tool)
    try:
        oracle_path = util.testname_to_oracle.get(testname, f"{EVAL_PATH}/benchmarks/{testname}/oracle.py")
        input_path = f"{EVAL_PATH}/benchmarks/{testname}/{testname}.wasm"
        reduced_path = f"{EVAL_PATH}/benchmarks/{testname}/{testname}.{util.tool_to_suffix[tool]}.wasm"

        command = tool_to_command(tool, input_path, oracle_path)
        entry_logger.info(f"Starting reduction for {testname} / {tool}")
        individual_logger.info('command:\n' + command)
        start_time = time.time()
        process = subprocess.Popen(
            command,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        for line in iter(process.stdout.readline, ''):
            individual_logger.info(line.strip())
        stderr_output, _ = process.communicate()
        end_time = time.time()
        elapsed = end_time - start_time
        if stderr_output:
            entry_logger.error(stderr_output.strip())

        module_size, code_size, target_size = util.get_sizes(reduced_path)
        start_module_size = metrics[testname]['metadata']['module-size']
        if not (start_module_size > module_size):
            entry_logger.warning(f"Failed to reduce {testname} / {tool}")
        else:
            entry_logger.info(f"Finished reduction for {testname} / {tool}: Elapsed time: {elapsed} seconds, Module size: {module_size}, Code size: {code_size}, Target size: {target_size}")
        return [testname, tool, elapsed, module_size, code_size, target_size]
    except Exception as e:
        entry_logger.error(f"Failed to run {testname} - {tool}\nError: {str(e)}")
        individual_logger.error(f"Failed to run {testname} - {tool}\nError: {str(e)}")
        return [testname, tool, "fail", "fail", "fail", "fail"]


start_time = time.time()
with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_WORKER) as executor:
    futures = [
        executor.submit(run_reduction_tool, testname, tool)
        for testname in testset
        for tool in toolset
    ]
    for future in concurrent.futures.as_completed(futures):
        result = future.result()
        util.update_metrics(metrics, [result])
end_time = time.time()
elapsed = end_time - start_time
entry_logger.info(f"Took {elapsed}s ({elapsed / 3600}h)")