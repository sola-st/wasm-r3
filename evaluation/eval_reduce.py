import time, subprocess, json, os, concurrent, sys
import concurrent.futures
import util

TIMEOUT = 3600 * 24
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
FIDX_LIMIT = os.getenv("FIDX_LIMIT")
ONLY_FAIL = os.getenv("ONLY_FAIL", False)
MAX_WORKER = int(os.getenv("MAX_WORKER", 8))

testname_to_oracle = {
    'boa': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'bullet': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-f7aca00.py", # fix RR-Reduce not working
    'commanderkeen': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-25e04ac.py",
    'ffmpeg': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-4e3e221.py",
    'figma-startpage': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-33ec201.py",
    'funky-kart': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'guiicons': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'hydro': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-708ea77.py",
    'jqkungfu': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-4e3e221.py",
    'jsc': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'mandelbrot': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-0b43b85.py",
    'pacalc': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-81555ab.py",
    'parquet': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-33ec201.py",
    'pathfinding': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-ccf0c56.py",
    'rfxgen': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'rguilayout': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'rguistyler': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'riconpacker': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'rtexviewer': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-708ea77.py",
    'sandspiel': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-ccf0c56.py",
    'sqlgui': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'wamr#2450': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-e360b7a.py",
    'wamr#2789': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-718f067.py",
    'wamr#2862': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-0ee5ffc.py",
    'wasmedge#3018': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
    'wasmedge#3019': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
    'wasmedge#3057': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
    'wasmedge#3076': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
}


with open("metrics.json", "r") as f:
    metrics = json.load(f)

TEST_NAMES = os.getenv("TEST_NAMES")
if TEST_NAMES:
    testset = TEST_NAMES.split(",")
else:
    testset = metrics.keys()
print(f"len(testset): {len(testset)}")



if len(sys.argv) < 2 or sys.argv[1] not in util.tool_to_suffix.keys():
    print("Usage: python rq1.py [wasm-slice|wasm-reduce|wasm-shrink|wasm-hybrid-all]")
    sys.exit(1)

tool_choice = sys.argv[1]
toolset = [tool_choice]

WASMR3_PATH = os.getenv("WASMR3_PATH", "/home/wasm-r3")

# Exit if BINARYEN_ROOT is not set
if "BINARYEN_ROOT" not in os.environ:
    print("Error: BINARYEN_ROOT environment variable is not set")
    print(
        "https://github.com/WebAssembly/binaryen/blob/871ff0d4f910b565c15f82e8f3c9aa769b01d286/src/support/path.cpp#L95"
    )
    sys.exit(1)


def tool_to_command(tool, test_input, oracle_script):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    if tool == "wasm-reduce":
        test_path = (
            f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.reduced_test.wasm"
        )
        work_path = f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.reduced.wasm"
        return f"wasm-reduce -to 60 -b $BINARYEN_ROOT/bin '--command=python {oracle_script} {test_path}' -t {test_path} -w {work_path} {test_input}"
    elif tool == "wasm-hybrid-all":
        suffix = util.tool_to_suffix[tool]
        test_path = f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.{suffix}_test.wasm"
        work_path = f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.{suffix}.wasm"
        wasm_slice_output_path = (
            f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.sliced.wasm"
        )
        return f"wasm-reduce -to 60 -b $BINARYEN_ROOT/bin '--command=python {oracle_script} {test_path}' -t {test_path} -w {work_path} {wasm_slice_output_path}"
    elif tool == "wasm-hybrid-target":
        suffix = util.tool_to_suffix[tool]
        test_path = f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.{suffix}_test.wasm"
        work_path = f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.{suffix}.wasm"
        wasm_slice_output_path = (
            f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.sliced.wasm"
        )
        return f"wasm-reduce-target -to 60 -b $BINARYEN_ROOT/bin '--command=python {oracle_script} {test_path}' -t {test_path} -w {work_path} {wasm_slice_output_path}"
    elif tool == "wasm-hybrid-remain":
        suffix = util.tool_to_suffix[tool]
        test_path = f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.{suffix}_test.wasm"
        work_path = f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.{suffix}.wasm"
        wasm_slice_output_path = (
            f"{WASMR3_PATH}/evaluation/benchmarks/{test_name}/{test_name}.sliced.wasm"
        )
        return f"wasm-reduce-remain -to 60 -b $BINARYEN_ROOT/bin '--command=python {oracle_script} {test_path}' -t {test_path} -w {work_path} {wasm_slice_output_path}"
    elif (
        tool == "wasm-shrink"
    ):  # https://github.com/doehyunbaek/wasm-tools/commit/5a9e4470f7023e08405d1d1e4e1fac0069680af1
        return f"wasm-tools shrink {oracle_script} {test_input}"
    elif tool == "wasm-slice":
        return f"/home/doehyunbaek/wasm-r3/rr-reduce/wasm-slice {oracle_script} {test_input}"
    else:
        exit("not supported")


def run_command(tool, oracle_script, test_input):
    command = f'timeout {TIMEOUT}s {tool_to_command(tool, test_input, oracle_script)}'

    if not command:
        print(f"Error: Unknown tool '{tool}'")
        sys.exit(1)
    print('command:\n', command)
    result = subprocess.run(
        command,
        shell=True,
        stdout=sys.stdout,
    )
    return result


def run_reduction_tool(testname, tool):
    try:
        oracle_path = testname_to_oracle.get(testname, f"{WASMR3_PATH}/evaluation/benchmarks/{testname}/oracle.py")
        input_path = f"{WASMR3_PATH}/evaluation/benchmarks/{testname}/{testname}.wasm"
        reduced_path = f"{WASMR3_PATH}/evaluation/benchmarks/{testname}/{testname}.{util.tool_to_suffix[tool]}.wasm"

        start_time = time.time()
        command = run_command(
            tool,
            oracle_path,
            input_path
        )
        end_time = time.time()
        elapsed = end_time - start_time

        oracle_command = f"python {oracle_path} {reduced_path}"

        max_retries = 3
        retry_count = 0
        while retry_count < max_retries:
            try:
                result = subprocess.run(oracle_command, shell=True, check=True)
                break  # If successful, exit the retry loop
            except subprocess.CalledProcessError as e:
                if e.returncode == 1:
                    print(
                        f"Oracle command failed with exit code 1. Retrying... (Attempt {retry_count + 1}/{max_retries})"
                    )
                    retry_count += 1
                    if retry_count == max_retries:
                        raise  # If all retries failed, raise the exception
                else:
                    raise  # If exit code is not 1, raise the exception immediately

        module_size, code_size, target_size = util.get_sizes(reduced_path)
        return [testname, tool, elapsed, module_size, code_size, target_size]
    except Exception as e:
        print(f"Failed to run {testname} - {tool}")
        print(f"Error: {str(e)}")
        return [testname, tool, "fail", "fail", "fail", "fail"]


def update_metrics(metrics, results):
    for testname, tool, elapsed, module_size, code_size, target_size in results:
        if metrics[testname].get(tool) is None:
            metrics[testname][tool] = {}
        metrics[testname][tool][f"time"] = elapsed
        metrics[testname][tool][f"module-size"] = module_size
        metrics[testname][tool][f"code-size"] = code_size
        if tool == 'wasm-slice':
            metrics[testname][tool][f"target-size"] = target_size

    with open("metrics.json", "w") as f:
        json.dump(metrics, f, indent=4)


if MAX_WORKER == 1:
    print("Running in single thread mode")
    for testname in testset:
        for tool in toolset:
            result = run_reduction_tool(testname, tool)
            update_metrics(metrics, [result])
else:
    with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_WORKER) as executor:
        futures = [
            executor.submit(run_reduction_tool, testname, tool)
            for testname in testset
            for tool in toolset
        ]
        for future in concurrent.futures.as_completed(futures):
            result = future.result()
            update_metrics(metrics, [result])
