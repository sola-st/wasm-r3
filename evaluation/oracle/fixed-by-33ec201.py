#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit 33ec201952ca2d8cef4fa2f93d9265395872c907
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Tue Feb 7 13:59:28 2023 -0500

#     [memory64] Parse initial and max memory sizes properly

# commit c0f4ac3763069d6d5f12fbcad7ffbcd935901c5a
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Tue Feb 7 12:24:48 2023 -0500

#     [memory64] Parse is64 bit on memory declarations

def wrong_on_target():
    command = f'timeout 10s wizard-c0f4ac3 -mode=int {WASM}'
    # command = f'timeout 10s /home/<anom>/wasm-r3/third_party/wizard-engine/bin/wizeng.x86-64-linux -mode=int {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    if result.returncode != 0 and result.returncode != 124: # error but not timeout
        return True
    else:
        return False

def correct_on_other():
    command = f'timeout 20s wizard-33ec201 -mode=int {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    if result.returncode == 0:
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
