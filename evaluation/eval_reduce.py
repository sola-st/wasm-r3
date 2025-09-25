import time, subprocess, json, os, concurrent, sys
import concurrent.futures
import util
import logging
from logging.handlers import RotatingFileHandler

BINARYEN_ROOT = os.getenv("BINARYEN_ROOT")
WASMR3_PATH = os.getenv("WASMR3_PATH")
EVAL_PATH = os.path.join(WASMR3_PATH, 'evaluation')

TIMEOUT = int(os.getenv("TIMEOUT", 3600 * 24))
MAX_WORKER = int(os.getenv("MAX_WORKER", 8))
BINARYEN_CORES = int(os.getenv("BINARYEN_CORES", 4))

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

console_handler = logging.StreamHandler(sys.stdout)
console_handler.setLevel(logging.INFO)
console_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
entry_logger.addHandler(console_handler)


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
if len(sys.argv) < 3 or sys.argv[1] not in list(valid_tools) + ["all"] or sys.argv[2] not in list(valid_tests) + ["all"]:
    entry_logger.error("Usage: python eval_reduce [<tool>|all] [<test>|all]")
    sys.exit(1)

metrics = util.load_metrics(f'{EVAL_PATH}/metrics.json')
tool_choice = sys.argv[1]
test_choice = sys.argv[2]
if test_choice == "all":
    prioritize = ['bullet', 'commanderkeen', 'hydro', 'rtexviewer', 'sandspiel', 'wamr#2450','wamr#2789', 'wamr#2862', 'wasmedge#3018', 'wasmedge#3019', 'wasmedge#3057', 'wasmedge#3076']
    testset =  prioritize + [test for test in valid_tests if test not in prioritize]
else:
    testset = [test_choice]

if tool_choice == "all":
    toolset = valid_tools
else:
    toolset = [tool_choice]

entry_logger.info(f"Starting experiment... you can also check {log_file} for this log")
entry_logger.info(f"MAX_WORKER: {MAX_WORKER}")
entry_logger.info(f"BINARYEN_CORES: {BINARYEN_CORES}")
entry_logger.info(f"TIMEOUT: {TIMEOUT}")
entry_logger.info(f"len(toolset): {len(toolset)}")
entry_logger.info(f'toolset: {toolset}')
entry_logger.info(f"len(testset): {len(testset)}")
entry_logger.info(f'testset: {testset}')

def tool_to_command(tool, test_input, oracle_script):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    if tool == "wasm-reduce":
        test_path = f"{EVAL_PATH}/benchmarks/{test_name}/{test_name}.reduced_test.wasm"
        work_path = f"{EVAL_PATH}/benchmarks/{test_name}/{test_name}.reduced.wasm"
        return f"timeout {TIMEOUT}s wasm-reduce -to 60 -b $BINARYEN_ROOT/bin '--command=python {oracle_script} {test_path}' -t {test_path} -w {work_path} {test_input} 2>&1"
    elif (
        tool == "wasm-shrink"
    ):
        return f"timeout {TIMEOUT}s wasm-tools shrink {oracle_script} {test_input}"
    elif tool == "wasm-slice":
        test_output = f"{EVAL_PATH}/benchmarks/{test_name}/{test_name}.sliced.wasm"
        return f"PRINT=1 BINARYEN_CORES=1  timeout {TIMEOUT}s wasm-slice {oracle_script} {test_input} {test_output}"
    elif tool == "wasm-hybrid":
        test_output = f"{EVAL_PATH}/benchmarks/{test_name}/{test_name}.hybrid.wasm"
        return f"PRINT=1 BINARYEN_CORES={BINARYEN_CORES} timeout {TIMEOUT}s wasm-hybrid {oracle_script} {test_input} {test_output}"
    else:
        exit("not supported")


def run_reduction_tool(testname, tool):
    individual_logger = setup_individual_logger(testname, tool)
    try:
        oracle_path = util.testname_to_oracle.get(testname, f"{EVAL_PATH}/benchmarks/{testname}/oracle.py")
        input_path = f"{EVAL_PATH}/benchmarks/{testname}/{testname}.wasm"
        reduced_path = f"{EVAL_PATH}/benchmarks/{testname}/{testname}.{util.tool_to_suffix[tool]}.wasm"

        command = tool_to_command(tool, input_path, oracle_path)
        entry_logger.info(f"Starting reduction for {tool} / {testname}, logging to {log_dir}/{testname}-{tool}.log")
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
            individual_logger.error(stderr_output.strip())

        module_size, code_size, target_size = util.get_sizes(reduced_path)
        start_module_size = metrics[testname]['metadata']['module-size']

        oracle_command = f"python {oracle_path} {reduced_path}"
        result = subprocess.run(oracle_command, shell=True, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        if not (result.returncode == 0 and start_module_size > module_size):
            entry_logger.warning(f"Failed to reduce {tool} / {testname}")
        else:
            if tool == "wasm-slice":
                entry_logger.info(f"Finished reduction for {tool} / {testname}: Elapsed time: {elapsed} seconds, Code size: {code_size:,}, Target size: {target_size:,}")
            else:
                entry_logger.info(f"Finished reduction for {tool} / {testname}: Elapsed time: {elapsed} seconds, Code size: {code_size:,}")
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