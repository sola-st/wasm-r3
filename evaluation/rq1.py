import subprocess, json, os, time
import concurrent.futures
import evaluation
from heuristics_finder import get_dynamic_fidx

TIMEOUT = 120
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
TEST_NAME = os.getenv("TEST_NAME")
FIDX_LIMIT = os.getenv("FIDX_LIMIT")
ONLY_FAIL = os.getenv("ONLY_FAIL", False)

with open("metrics.json", "r") as f:
    metrics = json.load(f)

print("RQ1")
testset = [TEST_NAME] if TEST_NAME else metrics.keys()
timeout_set = [
    "wasmedge#3018",
    "wasmedge#3019",
    "wasmedge#3057",
    "wasmedge#3076",
    "wamr#2789", # this doesn't terminate for original program as well
]


def run_reduction_tool(testname, fidx):
    tries = 0
    while tries < 3:
        try:
            tries += 1
            command = f"timeout {TIMEOUT}s npm test slicedice -- -t {testname} -i {fidx} --alternativeTrace --alternativeDownload"
            result = subprocess.run(command, shell=True, capture_output=True, text=True)
            return [testname, fidx, evaluation.extract_times(result.stdout)]
        except Exception as e:
            print(f"Failed to run {testname} - {fidx}\n{command}")
    return [testname, fidx, None]


total_time = 0
for testname in testset:
    # if metrics[testname]["metadata"]["function_count"] > 1000:
    #     continue
    # if testname in ['boa']:
    #      continue
    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as executor:
        didx = get_dynamic_fidx(f'~/wasm-r3/benchmarks/{testname}/{testname}.wasm')
        start_time = time.time()
        print(f"RUNNING: {testname} with {len(didx)} functions")
        futures = [
            executor.submit(run_reduction_tool, testname, fidx)
            for fidx in didx
        ]
        results = [
            future.result() for future in concurrent.futures.as_completed(futures)
        ]
        for testname, fidx, output in results:
            metrics[testname]["rq1"][str(fidx)] = output
            replay_path = f"replay/{testname}/{fidx}"
        with open("metrics.json", "w") as f:
            json.dump(metrics, f, indent=4)
        print(f"FINISHED: {testname} in {(time.time() - start_time) / 60} minutes")
        total_time += time.time() - start_time
print(f"Total time: {total_time / 60} minutes")
