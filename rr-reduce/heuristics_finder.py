import subprocess, re, csv, os

os.environ["PRINT"] = "1"          # force PRINT=1 to make heuristic work

def sh(cmd):
    import subprocess
    result = subprocess.run(cmd, shell=True, text=True, capture_output=True)
    return f'{result.stdout}\n{result.stderr}\n'

def extract_heuristic_fidx(command_output: str):
    # Pattern for both <wasm func #X> and <wasm function X>
    pattern = r'<wasm func(?:tion)? #?(\d+)>'
    matches = re.findall(pattern, command_output)

    if not matches:
        error_pattern = r'(?:^|\n)\s*\d+:\s*0x[0-9a-fA-F]+ - .*?!<wasm function (\d+)>'
        matches = re.findall(error_pattern, command_output, re.MULTILINE)

    if not matches:
        bailout_pattern = r'function #(\d+):'
        matches = re.findall(bailout_pattern, command_output)

    if not matches:
        bailout_pattern = r'\[spc-jit\] #(\d+)'
        matches = re.findall(bailout_pattern, command_output)

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

ffmpeg_output = '''CompletedProcess(args='timeout 10s wizard-253bd02 -mode=jit benchmarks/ffmpeg/out/186/benchmarks/bin_1/replay.wasm', returncode=3, stdout='benchmarks/ffmpeg/out/186/benchmarks/bin_1/replay.wasm:0x26A: bailed out compiling function #1: spill mismatch for rdx, assignment=41\n', stderr='')
CompletedProcess(args='timeout 20s wizard-4e3e221 -mode=jit benchmarks/ffmpeg/out/186/benchmarks/bin_1/replay.wasm', returncode=0, stdout='', stderr='')
Interesting!'''

bullet_output = '''CompletedProcess(args='timeout 10s wizard-d46ae4f -mode=jit /home/<anom>/wasm-r3/evaluation/benchmarks/bullet/bullet.wasm', returncode=255, stdout='', stderr='!NullCheckException\\n\\tin [spc-jit] #2706\\n\\tin [spc-jit] #1277\\n\\tin [spc-jit] #1278\\n\\tin [spc-jit] #2484\\n\\tin [spc-jit] #1252\\n\\tin [spc-jit] #1300\\n\\tin [spc-jit] #1345\\n\\tin [spc-jit] #1606\\n\\tin [spc-jit] #1624\\n\\tin [spc-jit] #1689\\n\\tin [spc-jit] #0\\n\\tin X86_64Spc.invoke() [src/engine/x86-64/X86_64SinglePassCompiler.v3 @ 794:57]\\n\\tin X86_64Runtime.invoke() [src/engine/x86-64/X86_64Runtime.v3 @ 117:48]\\n\\tin X86_64Runtime.runWithTailCalls() [src/engine/x86-64/X86_64Runtime.v3 @ 45:57]\\n\\tin X86_64Runtime.run() [src/engine/x86-64/X86_64Runtime.v3 @ 17:43]\\n\\tin X86_64SpcAotStrategy.call() [src/engine/x86-64/X86_64Target.v3 @ 141:41]\\n\\tin Execute.call() [src/engine/Execute.v3 @ 28:36]\\n\\tin main() [src/wizeng.main.v3 @ 144:29]\\n\\n')\nCompletedProcess(args='timeout 20s wizard-f7aca00 -mode=jit /home/<anom>/wasm-r3/evaluation/benchmarks/bullet/bullet.wasm', returncode=0, stdout='', stderr='')\nInteresting!'''

wasmedge3076_output = '''CompletedProcess(args='timeout 1s /home/<anom>/.wasmedge/bin/wasmedge compile /home/<anom>/wasm-r3/evaluation/benchmarks/wasmedge#3076/wasmedge#3076.wasm wasmedge#3076.wasm.so && timeout 1s /home/<anom>/.wasmedge/bin/wasmedge wasmedge#3076.wasm.so main', returncode=134, stdout='[2025-03-18 10:36:26.089] [info] compile start\n[2025-03-18 10:36:26.092] [info] verify start\n[2025-03-18 10:36:26.095] [info] optimize start\n[2025-03-18 10:36:26.178] [info] codegen start\n[2025-03-18 10:36:26.263] [info] output start\n[2025-03-18 10:36:26.266] [info] compile done\n[2025-03-18 10:36:26.553] [error] execution failed: integer divide by zero, Code: 0x404\n[2025-03-18 10:36:26.553] [error]     When executing function name: "main"\n', stderr='')
CompletedProcess(args='timeout 5s wasmtime --invoke main /home/<anom>/wasm-r3/evaluation/benchmarks/wasmedge#3076/wasmedge#3076.wasm', returncode=134, stdout='', stderr='Error: failed to run main module `/home/<anom>/wasm-r3/evaluation/benchmarks/wasmedge#3076/wasmedge#3076.wasm`\n\nCaused by:\n    0: failed to invoke `main`\n    1: error while executing at wasm backtrace:\n           0: 0x1f2e - <unknown>!<wasm function 7>\n           1: 0x1fbb - <unknown>!<wasm function 8>\n           2: 0x223a - <unknown>!<wasm function 12>\n           3: 0x2359 - <unknown>!<wasm function 13>\n           4: 0x7e2d - <unknown>!<wasm function 130>\n    2: memory fault at wasm address 0x10000204c in linear memory of size 0x100000000\n    3: wasm trap: out of bounds memory access\n')'''

assert extract_heuristic_fidx(boa_output) == [0, 103, 149, 286, 1476, 2824]
assert extract_heuristic_fidx(funky_kart) == [0, 431, 462, 1092, 1529]
assert extract_heuristic_fidx(wamr2450_output) == [17, 21, 22, 64, 65]
assert extract_heuristic_fidx(bullet_output) == [0, 1252, 1277, 1278, 1300, 1345, 1606, 1624, 1689, 2484, 2706]
assert extract_heuristic_fidx(ffmpeg_output) == [1]
assert extract_heuristic_fidx(wasmedge3076_output) == [7, 8, 12, 13, 130]

def get_heuristic_fidx(test_input, oracle_script) -> list:
    command = f'python {oracle_script} {test_input}'
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        # print(result)
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
            if dynamic_count > 0:
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
    output = sh(command)
    count = extract_function_count(output)
    return list(range(count))