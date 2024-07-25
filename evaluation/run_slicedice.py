import subprocess, json, concurrent.futures, re, os

test_name = os.getenv("TEST_NAME")
TIMEOUT = 120

with open("metrics.json", "r") as f:
    metrics = json.load(f)


def extract_times(input_string):
    # Define the pattern to match
    pattern = r"Running (slice-dice|wasm-r3|wasmtime): (\d+)(ms)"

    # Find all matches
    matches = re.findall(pattern, input_string)

    # Create a dictionary to store the results
    times = {"slice-dice": "fail", "wasm-r3": "fail"}

    for match in matches:
        key, value, unit = match
        value = int(value)
        times[key] = value  # Keep the value as is for milliseconds

    return times


# Test the function
input_string = """game-of-life-2:
    Running slice-dice: 16ms
    Running wasm-r3: 411ms"""

result = extract_times(input_string)


def run_slicedice(testname, fidx):
    try:
        command = f"timeout {TIMEOUT}s npm test slicedice -- -t {testname} -i {fidx}"
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return [testname, fidx, extract_times(result.stdout)]
    except Exception as e:
        print(f"Failed to run {testname} - {fidx}")
        print(e)
        return [testname, fidx, "fail"]


testset = [test_name] if test_name else sorted(metrics)
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as executor:
    futures = [
        executor.submit(run_slicedice, testname, fidx)
        for testname in testset
        for fidx in metrics[testname]
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

print("Slicedice run on all candidate benchmarks and fidx")
