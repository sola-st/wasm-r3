#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit 0ee5ffce8573a0e41f5a33dce562f541e98eb28a
# Author: Wenyong Huang <wenyong.huang@intel.com>
# Date:   Tue Mar 12 11:38:50 2024 +0800

#     Refactor APIs and data structures as preliminary work for Memory64 (#3209)

#     # Change the data type representing linear memory address from u32 to u64

#     ## APIs signature changes
#     - (Export)wasm_runtime_module_malloc
#       - wasm_module_malloc
#         - wasm_module_malloc_internal
#       - aot_module_malloc
#         - aot_module_malloc_internal
#     - wasm_runtime_module_realloc
#       - wasm_module_realloc
#         - wasm_module_realloc_internal
#       - aot_module_realloc
#         - aot_module_realloc_internal
#     - (Export)wasm_runtime_module_free
#       - wasm_module_free
#         - wasm_module_free_internal
#       - aot_module_malloc
#         - aot_module_free_internal
#     - (Export)wasm_runtime_module_dup_data
#       - wasm_module_dup_data
#       - aot_module_dup_data
#     - (Export)wasm_runtime_validate_app_addr
#     - (Export)wasm_runtime_validate_app_str_addr
#     - (Export)wasm_runtime_validate_native_addr
#     - (Export)wasm_runtime_addr_app_to_native
#     - (Export)wasm_runtime_addr_native_to_app
#     - (Export)wasm_runtime_get_app_addr_range
#     - aot_set_aux_stack
#     - aot_get_aux_stack
#     - wasm_set_aux_stack
#     - wasm_get_aux_stack
#     - aot_check_app_addr_and_convert, wasm_check_app_addr_and_convert
#       and jit_check_app_addr_and_convert
#     - wasm_exec_env_set_aux_stack
#     - wasm_exec_env_get_aux_stack
#     - wasm_cluster_create_thread
#     - wasm_cluster_allocate_aux_stack
#     - wasm_cluster_free_aux_stack

#     ## Data structure changes
#     - WASMModule and AOTModule
#       - field aux_data_end, aux_heap_base and aux_stack_bottom
#     - WASMExecEnv
#       - field aux_stack_boundary and aux_stack_bottom
#     - AOTCompData
#       - field aux_data_end, aux_heap_base and aux_stack_bottom
#     - WASMMemoryInstance(AOTMemoryInstance)
#       - field memory_data_size and change __padding to is_memory64
#     - WASMModuleInstMemConsumption
#       - field total_size and memories_size
#     - WASMDebugExecutionMemory
#       - field start_offset and current_pos
#     - WASMCluster
#       - field stack_tops

#     ## Components that are affected by the APIs and data structure changes
#     - libc-builtin
#     - libc-emcc
#     - libc-uvwasi
#     - libc-wasi
#     - Python and Go Language Embedding
#     - Interpreter Debug engine
#     - Multi-thread: lib-pthread, wasi-threads and thread manager

# commit b6216a5f8a5a6a6b7c516a5ad414c43ce904f400
# Author: Wenyong Huang <wenyong.huang@intel.com>
# Date:   Mon Mar 11 18:11:43 2024 +0800

#     Fix ip (bytecode offset) not committed into the latest aot frame (#3213)


def wrong_on_target():
    command = f'wamrc-b6216a5 -o wamr#2862.wasm.aot {WASM} && iwasm-b6216a5 --heap-size=o -f entry wamr#2862.wasm.aot'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    expected_output = '0x0:i32,0x0:i32,0x0:i32,0x0:i32'
    if expected_output in result.stdout:
        return True
    else:
        return False

def correct_on_other():
    command = f'wamrc-0ee5ffc -o wamr#2862.wasm.aot {WASM} && iwasm-0ee5ffc --heap-size=o -f entry wamr#2862.wasm.aot'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    expected_output = '''0x200d:i32,0x200d:i32,0x200d:i32,0x200d:i32'''
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
