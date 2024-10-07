import time, subprocess, json, os, concurrent, sys
import concurrent.futures

TIMEOUT = 3600
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
TEST_NAME = os.getenv("TEST_NAME")
FIDX_LIMIT = os.getenv("FIDX_LIMIT")
ONLY_FAIL = os.getenv("ONLY_FAIL", False)

with open("metrics.json", "r") as f:
    metrics = json.load(f)

testset = [TEST_NAME] if TEST_NAME else metrics.keys()
print(f"len(testset): {len(testset)}")

our_tool = ["wasm-slice"]

base_tool = [
    "wasm-reduce",
    "wasm-shrink",
]

tool_to_suffix = {
    "wasm-slice": "sliced",
    "wasm-reduce": "reduced",
    "wasm-shrink": "shrunken",
}

if len(sys.argv) < 2 or sys.argv[1] not in ["our-tool", "base-tool"]:
    print("Usage: python rq2.py [our-tool|base-tool]")
    sys.exit(1)

tool_choice = sys.argv[1]
toolset = our_tool if tool_choice == "our-tool" else base_tool


def run_reduction_tool(testname, tool):
    try:
        command = f"timeout {TIMEOUT}s python {WASMR3_PATH}/evaluation/run_reduction_tool.py {tool} {WASMR3_PATH}/benchmarks/{testname}/{testname}.wasm"
        start_time = time.time()
        subprocess.run(command, shell=True, capture_output=True, text=True)
        end_time = time.time()
        elapsed = end_time - start_time
        reduced_size = os.path.getsize(
            f"{WASMR3_PATH}/benchmarks/{testname}/{testname}.{tool_to_suffix[tool]}.wasm"
        )
        return [testname, tool, elapsed, reduced_size]
    except Exception as e:
        print(f"Failed to run {testname} - {tool}")
        print(
            f"timeout {TIMEOUT}s python {WASMR3_PATH}/evaluation/run_reduction_tool.py {tool} {WASMR3_PATH}/benchmarks/{testname}/{testname}.wasm"
        )
        return [testname, tool, "fail", "fail"]


with concurrent.futures.ThreadPoolExecutor(max_workers=8) as executor:
    futures = [
        executor.submit(run_reduction_tool, testname, tool)
        for testname in testset
        for tool in toolset
    ]
    results = [future.result() for future in concurrent.futures.as_completed(futures)]
    for testname, tool, elapsed, reduced_size in results:
        if metrics[testname].get("rq2") is None:
            metrics[testname]["rq2"] = {}
        metrics[testname]["rq2"][f"{tool}-size"] = reduced_size
        metrics[testname]["rq2"][f"{tool}-time"] = elapsed
    with open("metrics.json", "w") as f:
        json.dump(metrics, f, indent=4)

with open("metrics.json", "w") as f:
    json.dump(metrics, f, indent=4)
