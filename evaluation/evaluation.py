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
