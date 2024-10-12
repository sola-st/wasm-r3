import json, os

def sh(cmd):
    import subprocess
    result = subprocess.run(cmd, shell=True, text=True, capture_output=True)
    return f'{result.stdout}\n{result.stderr}\n'


with open("metrics.json", "r") as f:
    metrics = json.load(f)

wamr_2861_objdump_output = '''====wamr#2861====
  types                                  |        0xa -       0x16 |        12 bytes | 1 count
  functions                              |       0x18 -       0x1a |         2 bytes | 1 count
  memories                               |       0x1c -       0x24 |         8 bytes | 1 count
  globals                                |       0x26 -       0x30 |        10 bytes | 1 count
  exports                                |       0x32 -       0x3b |         9 bytes | 1 count
  code                                   |       0x3e -      0x27e |       576 bytes | 1 count
  data                                   |      0x281 -     0x1278 |      4087 bytes | 1 count
'''

def extract_code_bytes(objdump_output):
    lines = objdump_output.split('\n')
    for line in lines:
        if 'code' in line:
            return int(line.split()[6])

assert extract_code_bytes(wamr_2861_objdump_output) == 576

for test_name, data in metrics.items():
    dirname = os.path.dirname(data['metadata']['path'])
    oracle_path = os.path.join(dirname, 'oracle.py')
    input_path = os.path.join(dirname, f'{test_name}.wasm')
    rr_reduce_path = os.path.join(dirname, f'{test_name}.sliced.wasm')
    wasm_reduce_path = os.path.join(dirname, f'{test_name}.reduced.wasm')
    wasm_shrink_path = os.path.join(dirname, f'{test_name}.shrunken.wasm')

    print(f'===={test_name}====')
    for path in [input_path, rr_reduce_path, wasm_reduce_path, wasm_shrink_path]:
        result = sh(f'python {oracle_path} {path}')
        if 'Interesting!' in result:
            size = os.path.getsize(path)
            objdump_result = sh(f'wasm-tools objdump {path}')
            code_bytes = extract_code_bytes(objdump_result)
            prefix = None
            if path == input_path:
                prefix = 'original'
            elif path == rr_reduce_path:
                prefix = 'wasm-slice'
            elif path == wasm_reduce_path:
                prefix = 'wasm-reduce'
            elif path == wasm_shrink_path:
                prefix = 'wasm-shrink'
            metrics[test_name]['rq2'][f'{prefix}-size'] = size
            metrics[test_name]['rq2'][f'{prefix}-size-code'] = code_bytes
        elif 'Not interesting' in result:
            print(f'WARNING: {path} is not interesting')
            # os.remove(path)
        else:
            result = result.strip()
            print(f'{result}')
with open("metrics.json", "w") as f:
    json.dump(metrics, f, indent=4)