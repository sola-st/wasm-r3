#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil

WASMR3_PATH = os.getenv("WASMR3_PATH", "/home/wasm-r3")

# Exit if BINARYEN_ROOT is not set
if "BINARYEN_ROOT" not in os.environ:
    print("Error: BINARYEN_ROOT environment variable is not set")
    print("https://github.com/WebAssembly/binaryen/blob/871ff0d4f910b565c15f82e8f3c9aa769b01d286/src/support/path.cpp#L95")
    sys.exit(1)

test_to_mode = {
    # fixed by https://github.com/titzer/wizard-engine/commit/6d2b05742997441fd4ac01d1cd18d71046cec703
    'boa': 'MODE=int',
    'funky-kart': 'MODE=int',
    'guiicons': 'MODE=int',
    'jsc': 'MODE=int',
    'rfxgen': 'MODE=int',
    'rguilayout': 'MODE=int',
    'rguistyler': 'MODE=int',
    'riconpacker': 'MODE=int',
    'sqlgui': 'MODE=int',
    # fixed by https://github.com/titzer/wizard-engine/commit/25e04ac38279a3000b9a6671636a31108a45a388
    'commanderkeen': 'MODE=int',
    # fixed by https://github.com/titzer/wizard-engine/commit/708ea7758ea30086e77b72e2b4e80369d7373266
    'hydro': 'MODE=spc',
    'rtexviewer': 'MODE=spc',
    # fixed by https://github.com/titzer/wizard-engine/commit/0b43b85620e972c4180521a40ab48260cefba209
    'mandelbrot': 'MODE=spc',
}

def tool_to_command(tool, test_name):
    if tool == "wasm-reduce":
        test_path = f'./benchmarks/{test_name}/{test_name}.reduced.wasm'
        return f"wasm-reduce -to 10 -b $BINARYEN_ROOT/bin '--command={WASMR3_PATH}/evaluation/interesting.py {test_path}' -t {test_path} -w work.reduced.wasm"
    elif tool == "wasm-shrink":
        return f"wasm-tools shrink {WASMR3_PATH}/evaluation/interesting.py"
    elif tool == "wasm-slice":
        return  f"wasm-slice {WASMR3_PATH}/evaluation/interesting.py"
    else:
        exit("not supported")

def run_command(tool, test_input):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    mode = test_to_mode.get(test_name, '')
    command = tool_to_command(tool, test_name)
    
    if not command:
        print(f"Error: Unknown tool '{tool}'")
        sys.exit(1)
    
    full_command = f"{mode} {command} {test_input}"
    result = subprocess.run(
        full_command,
        shell=True,
        stdout=sys.stdout,
    )
    
    return result

# The Wasm file is given as the first and only argument to the script.
if len(sys.argv) != 3:
    print("Usage: run_reduction_tool.py <TOOL> <WASM_FILE>")
    sys.exit(1)

TOOL = sys.argv[1]
WASM = sys.argv[2]

result = run_command(TOOL, WASM)
