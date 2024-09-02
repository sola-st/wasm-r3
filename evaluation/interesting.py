#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil

ENGINE = os.getenv("ENGINE", "wizard-0d6926f")
MODE= os.getenv("MODE", "int")
get_mode = { 
    "int": "-mode=int",
    "spc": "-mode=spc",
}


def run_command(engine, test_input):
    test_name = os.path.splitext(os.path.basename(test_input))[0]
    if not test_name.endswith('.wasm'):
        test_name += '.wasm'
    
    # Get the parent directory of the test_input
    parent_dir = os.path.dirname(test_input)
    
    # Create a new destination path in the same directory as the test_input
    destination = os.path.join(parent_dir, test_name)
    
    # Copy the file to the new destination
    shutil.copyfile(test_input, destination)
    
    # Use the new destination as the test input
    result = subprocess.run(
        [engine, get_mode[MODE], destination],
        capture_output=True,
        text=True,
    )
    
    return result

# The Wasm file is given as the first and only argument to the script.
if len(sys.argv) != 2:
    print("Usage: interesting.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]

result = run_command(ENGINE, WASM)

# Check if the output contains the target bug's panic message
def is_runnable(result):
    return result.stdout.find('no main export from module') == -1

if result.returncode != 0 and is_runnable(result):
    print("Return code is not 0, interesting!")
    sys.exit(0)
else:
    print("Return code is 0, not interesting")
    sys.exit(1)
