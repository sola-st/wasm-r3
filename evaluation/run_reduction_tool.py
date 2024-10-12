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

def tool_to_command(tool, test_input, oracle_script):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    if tool == "wasm-reduce":
        test_path = f'{WASMR3_PATH}/benchmarks/{test_name}/{test_name}.reduced_test.wasm'
        work_path = f'{WASMR3_PATH}/benchmarks/{test_name}/{test_name}.reduced.wasm'
        return f"wasm-reduce -to 60 -b $BINARYEN_ROOT/bin '--command={oracle_script} {test_path}' -t {test_path} -w {work_path} {test_input}"
    elif tool == "wasm-shrink": # https://github.com/doehyunbaek/wasm-tools/commit/5a9e4470f7023e08405d1d1e4e1fac0069680af1
        return f"wasm-tools shrink {oracle_script} {test_input}"
    elif tool == "wasm-slice":
        return  f"wasm-slice {oracle_script} {test_input}"
    else:
        exit("not supported")

def run_command(tool, test_input, oracle_script):
    command = tool_to_command(tool, test_input, oracle_script)

    if not command:
        print(f"Error: Unknown tool '{tool}'")
        sys.exit(1)

    result = subprocess.run(
        command,
        shell=True,
        stdout=sys.stdout,
    )

    return result

if len(sys.argv) != 4:
    print("Usage: run_reduction_tool.py <TOOL> <ORACLE_SCRIPT> <WASM_FILE>")
    sys.exit(1)

TOOL = sys.argv[1]
ORACLE_SCRIPT = sys.argv[2]
WASM = sys.argv[3]

result = run_command(TOOL, WASM, ORACLE_SCRIPT)
