import os, subprocess, re, json

WASMR3_PATH = os.getenv("WASMR3_PATH", "/home/wasm-r3")
TEST_NAME = os.getenv("TEST_NAME")

with open("metrics.json", "r") as f:
    old_metrics = json.load(f)


def get_benchmarks():
    online_tests_path = os.path.join(WASMR3_PATH, "benchmarks")
    return [
        name
        for name in os.listdir(online_tests_path)
        if os.path.isdir(os.path.join(online_tests_path, name))
    ]


def get_subset_fidx(testname: str) -> list:
    if old_metrics.get(testname) and len(old_metrics.get(testname)) > 0:
        return list(old_metrics.get(testname))
    print(f"Getting fid candidates for {testname}: ", end="", flush=True)
    replay_wasm_path = os.path.join(
        WASMR3_PATH, "benchmarks", testname, f"{testname}.wasm"
    )
    subset_of_fidx = []
    try:
        subprocess.run(
            [f"{WASMR3_PATH}/target/release/slice_dice", replay_wasm_path],
            check=True,
            capture_output=True,
            text=True,
        )
    except subprocess.CalledProcessError as e:
        matches = re.findall(r"\d+", e.stdout)
        if matches:
            subset_of_fidx = list(map(int, matches))
    print(f"{subset_of_fidx}")
    return subset_of_fidx


testset = get_benchmarks()
metrics = {
    testname: {fidx: {} for fidx in get_subset_fidx(testname)} for testname in testset
}

with open("metrics.json", "w") as f:
    json.dump(metrics, f, indent=4)

print("Enumeration of benchmarks and fidxs done.")
