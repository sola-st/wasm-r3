#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil


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

tool_to_command = {
    "wasm-reduce": "",
    "wasm-shrink": "wasm-tools shrink evaluation/interesting.py",
    "slicedice": "",
}

def run_command(tool, test_input):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    mode = test_to_mode.get(test_name, '')
    command = tool_to_command.get(tool, '')
    
    if not command:
        print(f"Error: Unknown tool '{tool}'")
        sys.exit(1)
    
    full_command = f"{command} {test_input}"
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
