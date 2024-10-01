import subprocess, json, os
import concurrent.futures
import eval

TIMEOUT = 120
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")

with open("metrics.json", "r") as f:
    metrics = json.load(f)

testset = eval.testset
print("RQ1")
print(f"len(testset): {len(testset)}")


def run_reduction_tool(testname, fidx):
    try:
        command = f"timeout {TIMEOUT}s npm test slicedice -- -t {testname} -i {fidx}"
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return [testname, fidx, eval.extract_times(result.stdout)]
    except Exception as e:
        print(f"Failed to run {testname} - {fidx}\n{command}")
        return [testname, fidx, None]


for testname in testset:
    if testname not in metrics:
        metrics[testname] = {}

with concurrent.futures.ThreadPoolExecutor(max_workers=1) as executor:
    futures = [
        executor.submit(run_reduction_tool, testname, fidx)
        for testname in testset
        for fidx in eval.get_all_fidx(f'{WASMR3_PATH}/benchmarks/{testname}/{testname}.wasm')
    ]
    results = [future.result() for future in concurrent.futures.as_completed(futures)]

for result in results:
    if result is None:
        continue
    testname, fidx, output = result
    metrics[testname][fidx] = output
with open("metrics.json", "w") as f:
    sorted_metrics = {k: metrics[k] for k in sorted(metrics)}
    json.dump(sorted_metrics, f, indent=4)