import subprocess, re, os

WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
TEST_NAME = os.getenv("TEST_NAME")

r3bench_testset = [
    "boa",  # this doesn't work for wasm-slice
    "guiicons",
    "funky-kart",
    "jsc",
    "rfxgen",
    "rguilayout",
    "rguistyler",
    "riconpacker",
    "sqlgui",
    "commanderkeen",
    "hydro",
    "rtexviewer",
    "mandelbrot",
]

wasmaker_testset = [
    "wasmedge#3057",
    "wasmedge#3076",
    "wamr#2450", # works
    "wasmedge#3019",
    "wamr#2789", # try with alternateTrace
    "wamr#2862", # works
    "wasmedge#3018",
    "wamr#2861", # works
]

testset = [TEST_NAME] if TEST_NAME else r3bench_testset + wasmaker_testset


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



def get_all_fidx(test_input):
    command = f"wasm-tools objdump {test_input}"
    output = subprocess.check_output(command, shell=True, text=True)
    count = extract_function_count(output)
    return list(range(count))
