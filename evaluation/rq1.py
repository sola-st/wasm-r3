import subprocess, json, os, time
import concurrent.futures
import evaluation

TIMEOUT = 120
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
TEST_NAME = os.getenv("TEST_NAME")
FIDX_LIMIT = os.getenv("FIDX_LIMIT")

with open("metrics.json", "r") as f:
    metrics = json.load(f)

print("RQ1")
testset = [TEST_NAME] if TEST_NAME else metrics.keys()


def run_reduction_tool(testname, fidx):
    try:
        command = f"timeout {TIMEOUT}s npm test slicedice -- -t {testname} -i {fidx} --alternativeTrace --alternativeDownload"
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return [testname, fidx, evaluation.extract_times(result.stdout)]
    except Exception as e:
        print(f"Failed to run {testname} - {fidx}\n{command}")
        return [testname, fidx, None]


metrics = dict(
    sorted(metrics.items(), key=lambda x: x[1]["metadata"]["function_count"])
)

total_time = 0
for testname in testset:
    if testname in ['boa']:
         continue
    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as executor:
            fidx_count = min(metrics[testname]["metadata"]["function_count"], int(FIDX_LIMIT)) if FIDX_LIMIT else metrics[testname]["metadata"]["function_count"]
            print(f"RUNNING: {testname} with {fidx_count} functions")
            fidx_range = range(fidx_count)
            start_time = time.time()
            futures = [
                executor.submit(run_reduction_tool, testname, fidx)
                for fidx in fidx_range
            ]
            results = [
                future.result() for future in concurrent.futures.as_completed(futures)
            ]
            metrics[testname]["rq1"] = {}
            for testname, fidx, output in results:
                metrics[testname]["rq1"][fidx] = output
            with open("metrics.json", "w") as f:
                json.dump(metrics, f, indent=4)
            print(f"FINISHED: {testname} in {time.time() - start_time} seconds")
            total_time += time.time() - start_time
print(f"Total time: {total_time}")
