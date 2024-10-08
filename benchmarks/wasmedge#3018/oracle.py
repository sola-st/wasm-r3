#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]


def wrong_on_target():
    command = f'wasmedge-96ecb67 compile {WASM} wasmedge#3018.wasm.so && timeout 1s wasmedge-96ecb67 wasmedge#3018.wasm.so main'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    print(result)
    if result.returncode == 0:
        return True
    else:
        return False

def correct_on_other():
    command = f'wasmtime --invoke main {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    print(result)
    expected_output = 'wasm trap: out of bounds memory access'
    if expected_output in result.stderr:
        return True
    else:
        return False

if not os.path.isfile(WASM):
    print(f"Error: The file {WASM} does not exist.")
    sys.exit(2)

if wrong_on_target() and correct_on_other():
    print("Interesting!")
    sys.exit(0)
else:
    print("Not interesting")
    sys.exit(1)
