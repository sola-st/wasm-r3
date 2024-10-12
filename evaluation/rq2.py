import time, subprocess, json, os, concurrent, sys
import concurrent.futures

TIMEOUT = 3600
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
FIDX_LIMIT = os.getenv("FIDX_LIMIT")
ONLY_FAIL = os.getenv("ONLY_FAIL", False)
MAX_WORKER = int(os.getenv("MAX_WORKER", 8))

with open("metrics.json", "r") as f:
    metrics = json.load(f)

TEST_NAMES = os.getenv("TEST_NAMES")
if TEST_NAMES:
    testset = TEST_NAMES.split(',')
else:
    testset = metrics.keys()
print(f"len(testset): {len(testset)}")

tool_to_suffix = {
    "wasm-slice": "sliced",
    "wasm-reduce": "reduced",
    "wasm-shrink": "shrunken",
}

if len(sys.argv) < 2 or sys.argv[1] not in tool_to_suffix.keys():
    print("Usage: python rq2.py [wasm-slice|wasm-reduce|wasm-shrink]")
    sys.exit(1)

tool_choice = sys.argv[1]
toolset = [tool_choice]


def run_reduction_tool(testname, tool):
    try:
        command = f"timeout {TIMEOUT}s python {WASMR3_PATH}/evaluation/run_reduction_tool.py {tool} {WASMR3_PATH}/benchmarks/{testname}/oracle.py {WASMR3_PATH}/benchmarks/{testname}/{testname}.wasm"
        start_time = time.time()
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        end_time = time.time()
        elapsed = end_time - start_time

        oracle_path = f"{WASMR3_PATH}/benchmarks/{testname}/oracle.py"
        reduced_path = f"{WASMR3_PATH}/benchmarks/{testname}/{testname}.{tool_to_suffix[tool]}.wasm"
        oracle_command = f'python {oracle_path} {reduced_path}'

        max_retries = 3
        retry_count = 0
        while retry_count < max_retries:
            try:
                result = subprocess.run(oracle_command, shell=True, check=True)
                break  # If successful, exit the retry loop
            except subprocess.CalledProcessError as e:
                if e.returncode == 1:
                    print(f"Oracle command failed with exit code 1. Retrying... (Attempt {retry_count + 1}/{max_retries})")
                    retry_count += 1
                    if retry_count == max_retries:
                        raise  # If all retries failed, raise the exception
                else:
                    raise  # If exit code is not 1, raise the exception immediately

        reduced_size = os.path.getsize(reduced_path)
        return [testname, tool, elapsed, reduced_size]
    except Exception as e:
        print(f"Failed to run {testname} - {tool}")
        print(command)
        print(f"Error: {str(e)}")
        return [testname, tool, "fail", "fail"]


def update_metrics(metrics, results):
    for testname, tool, elapsed, reduced_size in results:
        if metrics[testname].get("rq2") is None:
            metrics[testname]["rq2"] = {}
        metrics[testname]["rq2"][f"{tool}-size"] = reduced_size
        metrics[testname]["rq2"][f"{tool}-time"] = elapsed
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
        results = [future.result() for future in concurrent.futures.as_completed(futures)]
        update_metrics(metrics, results)
