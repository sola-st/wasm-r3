#!/usr/bin/env python3

import os
import sys
import subprocess

if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]


def wrong_on_target():
    command = f"wamrc-7308b1e -o wamr#2861.wasm.aot {WASM} && iwasm-7308b1e --heap-size=o -f entry wamr#2861.wasm.aot"
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    print(result)
    expected_output = "0x10000:i32,0x10000:i32,0x10000:i32,0x10000:i32,0x10000:i32,0x10000:i32,-1.127242e+18:f32,0x75a142e20792c8c8:i64"
    if expected_output in result.stdout:
        return True
    else:
        return False


def correct_on_other():
    command = f"wasmtime --invoke entry {WASM}"
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    print(result)
    expected_output = """0
0
0
0
0
0"""
    if expected_output in result.stdout:
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
