import time, subprocess, json, os, concurrent
import eval

TIMEOUT = 120
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")

with open("metrics.json", "r") as f:
    metrics = json.load(f)

testset = eval.testset
# print(testset)
# testset = ["wamr#2862"]
print(f"len(testset): {len(testset)}")

our_tool = ["wasm-slice"]

toolset = [
    "wasm-reduce",
    "wasm-shrink",
]

tool_to_suffix = {
    "wasm-slice": "sliced",
    "wasm-reduce": "reduced",
    "wasm-shrink": "shrunken",
}


def run_reduction_tool(testname, tool):
    try:
        command = f"timeout {TIMEOUT}s python {WASMR3_PATH}/evaluation/run_reduction_tool.py {tool} {WASMR3_PATH}/benchmarks/{testname}/{testname}.wasm"
        start_time = time.time()
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
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


for testname in testset:
    if testname not in metrics:
        metrics[testname] = {}
    if "reduction_comparison" not in metrics[testname]:
        metrics[testname]["reduction_comparison"] = {}
    metrics[testname]["reduction_comparison"].update(
        {
            "original_size": os.path.getsize(
                f"{WASMR3_PATH}/benchmarks/{testname}/{testname}.wasm"
            )
        }
    )

with concurrent.futures.ThreadPoolExecutor(max_workers=8) as executor:
    futures = [
        executor.submit(run_reduction_tool, testname, tool)
        for testname in testset
        for tool in our_tool
    ]
    results = [future.result() for future in concurrent.futures.as_completed(futures)]

# with concurrent.futures.ThreadPoolExecutor(max_workers=8) as executor:
#     futures = [
#         executor.submit(run_reduction_tool, testname, tool)
#         for testname in testset
#         for tool in toolset
#     ]
#     results = results + [
#         future.result() for future in concurrent.futures.as_completed(futures)
#     ]

for result in results:
    testname, tool, elapsed, reduced_size = result
    metrics[testname]["reduction_comparison"][f"{tool}-size"] = reduced_size
    metrics[testname]["reduction_comparison"][f"{tool}-time"] = elapsed

with open("metrics.json", "w") as f:
    sorted_metrics = {k: metrics[k] for k in sorted(metrics)}
    json.dump(sorted_metrics, f, indent=4)
