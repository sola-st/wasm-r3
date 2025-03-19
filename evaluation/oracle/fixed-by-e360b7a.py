#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

# commit e360b7a919247d2ab4d0363e1edf53bd8c073210 (HEAD)
# Author: YAMAMOTO Takashi <yamamoto@midokura.com>
# Date:   Mon Aug 14 18:27:14 2023 +0900

#     wasm_instantiate: Fix a potential integer overflow issue (#2459)

#     Fixes: https://github.com/bytecodealliance/wasm-micro-runtime/issues/2450

# commit 8d1cf46f02a27f52b24103b5d5b5511dd3990a31
# Author: tonibofarull <toni.bofarull@midokura.com>
# Date:   Mon Aug 14 10:45:30 2023 +0200

#     Implement `wasm_externref_objdel` and `wasm_externref_set_cleanup` (#2455)

#     ## Context

#     Some native libraries may want to explicitly delete an externref object without
#     waiting for the module instance to be deleted.
#     In addition, it may want to add a cleanup function.

#     ## Proposed Changes

#     Implement:
#     * `wasm_externref_objdel` to explicitly delete an externeref'd object.
#     * `wasm_externref_set_cleanup` to set a cleanup function that is called when
#       the externref'd object is deleted.

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')


def wrong_on_target():
    command = f'iwasm-8d1cf46 --heap-size=0 -f main {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    expected_output = 'WASM module instantiate failed: data segment does not fit'
    if expected_output in result.stdout:
        return True
    else:
        return False

def correct_on_other():
    command = f'iwasm-e360b7a --heap-size=0 -f main {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    expected_output = 'WASM module instantiate failed: data segment does not fit'
    if expected_output not in result.stdout:
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
