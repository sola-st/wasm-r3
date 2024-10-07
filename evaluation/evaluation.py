import subprocess, re, os, json

WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
PAPER_PATH = os.getenv("PAPER_PATH", "/home/don/rr-reduce-paper/issta_2025")
TEST_NAME = os.getenv("TEST_NAME")


def extract_function_count(objdump_output):
    for line in objdump_output.split("\n"):
        if "functions" in line:
            match = re.search(r"(\d+) count", line)
            if match:
                return int(match.group(1))
    return None


test_get_function_count = """
types                                  |        0xb -      0x198 |       397 bytes | 55 count
functions                              |      0x19b -      0x396 |       507 bytes | 505 count
tables                                 |      0x398 -      0x39f |         7 bytes | 1 count
memories                               |      0x3a1 -      0x3a7 |         6 bytes | 1 count
globals                                |      0x3aa -      0x930 |      1414 bytes | 282 count
exports                                |      0x933 -     0x100c |      1753 bytes | 301 count
elements                               |     0x100f -     0x1193 |       388 bytes | 1 count
data count                             |     0x1195 -     0x1197 |         2 bytes | 1 count
code                                   |     0x119b -    0x46e2b |    285840 bytes | 505 count
data                                   |    0x46e2f -    0x5c006 |     86487 bytes | 1422 count
"""

assert extract_function_count(test_get_function_count) == 505


def get_all_fidx(test_input):
    command = f"wasm-tools objdump {test_input}"
    output = subprocess.check_output(command, shell=True, text=True)
    count = extract_function_count(output)
    return list(range(count))


metrics = {
    "boa": {  # this doesn't work for wasm-slice
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/boa/boa.wasm",
        }
    },
    "guiicons": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/guiicons/guiicons.wasm",
        }
    },
    "funky-kart": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/funky-kart/funky-kart.wasm",
        }
    },
    "jsc": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/jsc/jsc.wasm",
        }
    },
    "rfxgen": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/rfxgen/rfxgen.wasm",
        }
    },
    "rguilayout": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/rguilayout/rguilayout.wasm",
        }
    },
    "rguistyler": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/rguistyler/rguistyler.wasm",
        }
    },
    "riconpacker": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/riconpacker/riconpacker.wasm",
        }
    },
    "sqlgui": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/sqlgui/sqlgui.wasm",
        }
    },
    "commanderkeen": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/commanderkeen/commanderkeen.wasm",
        }
    },
    "hydro": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/hydro/hydro.wasm",
        }
    },
    "rtexviewer": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/rtexviewer/rtexviewer.wasm",
        }
    },
    "mandelbrot": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "wizard-0d6926f",
            "path": f"{WASMR3_PATH}/benchmarks/mandelbrot/mandelbrot.wasm",
        }
    },
    "wasmedge#3057": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "wasmedge-96ecb67",
            "path": f"{WASMR3_PATH}/benchmarks/wasmedge#3057/wasmedge#3057.wasm",
        }
    },
    "wasmedge#3076": {  # this doesn't work for wasm-slice
        "metadata": {
            "origin": "WASMaker",
            "engine": "wasmedge-96ecb67",
            "path": f"{WASMR3_PATH}/benchmarks/wasmedge#3076/wasmedge#3076.wasm",
        }
    },
    "wamr#2450": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "wamr-0b0af1b",
            "path": f"{WASMR3_PATH}/benchmarks/wamr#2450/wamr#2450.wasm",
        }
    },
    "wasmedge#3019": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "wasmedge-96ecb67",
            "path": f"{WASMR3_PATH}/benchmarks/wasmedge#3019/wasmedge#3019.wasm",
        }
    },
    "wamr#2789": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "wamr-0b0af1b",
            "path": f"{WASMR3_PATH}/benchmarks/wamr#2789/wamr#2789.wasm",
        }
    },
    "wamr#2862": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "wamr-7308b1e",
            "path": f"{WASMR3_PATH}/benchmarks/wamr#2862/wamr#2862.wasm",
        }
    },
    "wasmedge#3018": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "wasmedge-96ecb67",
            "path": f"{WASMR3_PATH}/benchmarks/wasmedge#3018/wasmedge#3018.wasm",
        }
    },
    "wamr#2861": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "wamr-7308b1e",
            "path": f"{WASMR3_PATH}/benchmarks/wamr#2861/wamr#2861.wasm",
        }
    },
}

# get byte size
for testname in metrics:
    metrics[testname]['metadata']["size"] = os.path.getsize(metrics[testname]["metadata"]["path"])

for testname in metrics:
    metrics[testname]['metadata']["function_count"] = len(
        get_all_fidx(metrics[testname]["metadata"]["path"])
    )

# with open("metrics.json", "w") as f:
#     sorted_metrics = dict(sorted(metrics.items(), key=lambda item: item[1]['metadata']['function_count']))
#     json.dump(sorted_metrics, f, indent=4)

testset = [TEST_NAME] if TEST_NAME else metrics.keys()


import re

def extract_times(input_string):
    # Define the pattern to match times, including possible timeout
    time_pattern = r"Running (slice-dice|wasm-r3|wasmtime): (\d+)(ms)(\(timeout\))?"

    # Define the pattern to match sliced file size
    size_pattern = r"Sliced file size: (\d+)bytes"

    # Find all matches for times
    time_matches = re.findall(time_pattern, input_string)

    # Find match for sliced file size
    size_match = re.search(size_pattern, input_string)

    # Create a dictionary to store the results
    times = {
        "split-time": "fail",
        "rr-time": "fail",
        "rr-did-timeout": False,
        "sliced_file_size": "fail"
    }

    for match in time_matches:
        key, value, unit, timeout = match
        value = int(value)

        if key == "slice-dice":
            times["split-time"] = value
        elif key == "wasm-r3":
            times["rr-time"] = value
            if timeout:
                times["rr-did-timeout"] = True

    if size_match:
        times["sliced_file_size"] = int(size_match.group(1))

    return times

# Test the function
input_string1 = """wamr#2861-0: Running slice-dice: 25ms Running wasm-r3: 1811ms Sliced file size: 5006bytes"""
input_string2 = """wasmedge#3057-0: Running slice-dice: 345ms Running wasm-r3: 5485ms(timeout) Sliced file size: 39462bytes"""

result1 = extract_times(input_string1)
result2 = extract_times(input_string2)

# Assertions for result1
assert result1["split-time"] == 25, "Split time mismatch in result1"
assert result1["rr-time"] == 1811, "RR time mismatch in result1"
assert result1["sliced_file_size"] == 5006, "Sliced file size mismatch in result1"
assert result1["rr-did-timeout"] == False, "Timeout flag mismatch in result1"

# Assertions for result2
assert result2["split-time"] == 345, "Split time mismatch in result2"
assert result2["rr-time"] == 5485, "RR time mismatch in result2"
assert result2["sliced_file_size"] == 39462, "Sliced file size mismatch in result2"
assert result2["rr-did-timeout"] == True, "Timeout flag mismatch in result2"
