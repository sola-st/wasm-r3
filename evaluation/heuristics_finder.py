import subprocess, re, csv, os

def extract_heuristic_fidx(command_output: str):
    # Pattern for both <wasm func #X> and <wasm function X>
    pattern = r'<wasm func(?:tion)? #?(\d+)>'
    matches = re.findall(pattern, command_output)

    # If no matches found, try to find indices in the error message
    if not matches:
        error_pattern = r'(?:^|\n)\s*\d+:\s*0x[0-9a-fA-F]+ - .*?!<wasm function (\d+)>'
        matches = re.findall(error_pattern, command_output, re.MULTILINE)
    # TODO: evaluate preserving the order
    unique_indices = set(map(int, matches))
    sorted_indices = sorted(unique_indices)
    return sorted_indices

boa_output = '''CompletedProcess(args='timeout 10s wizard-0d6926f -no-names -mode=int ./benchmarks/boa/boa.wasm', returncode=10, stdout='<wasm func #0> +947\n  <wasm func #2824> +271155\n    <wasm func #149> +12365\n      <wasm func #286> +1141\n        <wasm func #1476> +74\n          <wasm func #149> +16705\n            <wasm func #103>\n              !trap[UNREACHABLE]\n', stderr='')
CompletedProcess(args='wasmtime --invoke main ./benchmarks/boa/boa.wasm', returncode=0, stdout='', stderr='')
Interesting!'''

funky_kart = ''' CompletedProcess(args='timeout 10s wizard-0d6926f -no-names -mode=int ./benchmarks/funky-kart/funky-kart.wasm', returncode=10, stdout='<wasm func #0> +153\n  <wasm func #1092> +3\n    <wasm func #462> +49\n      <wasm func #431> +60\n        <wasm func #1529> +82244\n          !trap[UNREACHABLE]\n', stderr='')
CompletedProcess(args='wasmtime --invoke main ./benchmarks/funky-kart/funky-kart.wasm', returncode=0, stdout='', stderr='')
Interesting!'''

wamr2450_output = '''CompletedProcess(args='iwasm-0b0af1b --heap-size=0 -f main ./benchmarks/wamr#2450/wamr#2450.wasm', returncode=255, stdout='WASM module instantiate failed: data segment does not fit\n', stderr='')
CompletedProcess(args='wasmtime --invoke main ./benchmarks/wamr#2450/wamr#2450.wasm', returncode=134, stdout='', stderr='Error: failed to run main module `./benchmarks/wamr#2450/wamr#2450.wasm`\n\nCaused by:\n    0: failed to invoke `main`\n    1: error while executing at wasm backtrace:\n           0: 0x1e80 - <unknown>!<wasm function 17>\n           1: 0x29ee - <unknown>!<wasm function 21>\n           2: 0x2b44 - <unknown>!<wasm function 22>\n           3: 0x5f9e - <unknown>!<wasm function 64>\n           4: 0x6329 - <unknown>!<wasm function 65>\n    2: wasm trap: integer divide by zero\n')
Interesting!'''

assert extract_heuristic_fidx(boa_output) == [0, 103, 149, 286, 1476, 2824]
assert extract_heuristic_fidx(funky_kart) == [0, 431, 462, 1092, 1529]
assert extract_heuristic_fidx(wamr2450_output) == [17, 21, 22, 64, 65]

def get_heuristic_fidx(test_input, oracle_script) -> list:
    command = f'python {oracle_script} {test_input}'
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return extract_heuristic_fidx(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"ERROR: {e}")
        return []


def extract_dynamic_fidx(csv_output: str):
    dynamic_fidx = []
    reader = csv.reader(csv_output.splitlines())
    next(reader)  # Skip header
    for row in reader:
        if len(row) >= 3:
            function_index = int(row[0].lstrip('#'))
            dynamic_count = int(row[2])
            if dynamic_count > 0 and function_index != 0:
                dynamic_fidx.append(function_index)
    return sorted(dynamic_fidx)

def get_dynamic_fidx(test_input):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    command = f'timeout 120s wizeng.x86-64-linux -no-names -csv --monitors=icount {test_input}'
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        csv_start = result.stdout.find('Function,static,dynamic')
        if csv_start == -1:
            print(f"WARNING: CSV output not found for {test_name}")
            return []
        csv_output = result.stdout[csv_start:]
        return extract_dynamic_fidx(csv_output)
    except subprocess.CalledProcessError as e:
        print(f"WARNING: No dynamic set found for {test_name}")
        return []

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