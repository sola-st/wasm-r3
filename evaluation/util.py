import re, os, json
import subprocess
WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
EVAL_PATH = os.path.join(WASMR3_PATH, 'evaluation')
PAPER_PATH = os.getenv("PAPER_PATH", "/home/don/rr-reduce-paper/issta_2025")
TEST_NAME = os.getenv("TEST_NAME")

def sh(cmd):
    import subprocess
    result = subprocess.run(cmd, shell=True, text=True, capture_output=True)
    return f'{result.stdout}\n{result.stderr}\n'

testname_to_oracle = {
    'boa': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'bullet': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-f7aca00.py",
    'commanderkeen': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-bc135ad.py",
    'ffmpeg': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-4e3e221.py",
    'figma-startpage': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-33ec201.py",
    'funky-kart': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'guiicons': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'hydro': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-708ea77.py",
    'jqkungfu': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-4e3e221.py",
    'jsc': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'mandelbrot': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-0b43b85.py",
    'pacalc': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-81555ab.py",
    'parquet': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-33ec201.py",
    'pathfinding': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-ccf0c56.py",
    'rfxgen': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'rguilayout': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'rguistyler': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'riconpacker': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'rtexviewer': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-708ea77.py",
    'sandspiel': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-ccf0c56.py",
    'sqlgui': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-6d2b057.py",
    'wamr#2450': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-e360b7a.py",
    'wamr#2789': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-718f067.py",
    'wamr#2862': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-0ee5ffc.py",
    'wasmedge#3018': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
    'wasmedge#3019': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
    'wasmedge#3057': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
    'wasmedge#3076': f"{WASMR3_PATH}/evaluation/oracle/fixed-by-93fd4ae.py",
}

def load_metrics(path):
    with open(path, "r") as f:
        return json.load(f)


def update_metrics(metrics, results):
    for testname, tool, elapsed, module_size, code_size, target_size in results:
        if metrics[testname].get(tool) is None:
            metrics[testname][tool] = {}
        metrics[testname][tool][f"time"] = elapsed
        metrics[testname][tool][f"module-size"] = module_size
        metrics[testname][tool][f"code-size"] = code_size
        if tool == 'wasm-slice':
            metrics[testname][tool][f"target-size"] = target_size

    with open("metrics.json", "w") as f:
        json.dump(metrics, f, indent=4)

def run_with_retries(command, max_retries=3):
            retry_count = 0
            while retry_count < max_retries:
                try:
                    result = subprocess.run(command, shell=True, check=True)
                    return result
                except subprocess.CalledProcessError as e:
                    if e.returncode == 1:
                        print(
                            f"Command failed with exit code 1. Retrying... (Attempt {retry_count + 1}/{max_retries})"
                        )
                        retry_count += 1
                        if retry_count == max_retries:
                            raise  # If all retries failed, raise the exception
                    else:
                        raise  # If exit code is not 1, raise the exception immediately

tool_to_suffix = {
    "wasm-slice": "sliced",
    "wasm-hybrid": "hybrid",
    "wasm-reduce": "reduced",
    "wasm-shrink": "shrunken",
    # "wasm-hybrid-target": "hybrid-target",
    # "wasm-hybrid-remain": "hybrid-remain",
}

short_case = [
    "rtexviewer",
    "hydro",
    "wamr#2450",
    "wamr#2789",
    "wamr#2862",
    # Should install wasmedge VERSION=0.13.4; curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash -s -- -v $VERSION
    "wasmedge#3018",
    "wasmedge#3019",
    "wasmedge#3057",
    "wasmedge#3076",
    # "boa",
]

long_case = [
    "boa",
    "rguistyler",
    "guiicons",
    "rguilayout",
    "rfxgen",
    "jsc",
    "mandelbrot",
    "riconpacker",
    "sqlgui",
    "funky-kart",
    "commanderkeen",
]

new_case = [
    'pacalc',
    # 'bullet',
    'sandspiel',
    # 'pathfinding',
    'parquet',
    'figma-startpage',
    'ffmpeg',
    'jqkungfu',
]

start_metrics = {
    "boa": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/boa/boa.wasm",
        }
    },
    "guiicons": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/guiicons/guiicons.wasm",
        }
    },
    "funky-kart": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/funky-kart/funky-kart.wasm",
        }
    },
    "jsc": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/jsc/jsc.wasm",
        }
    },
    "rfxgen": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/rfxgen/rfxgen.wasm",
        }
    },
    "rguilayout": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/rguilayout/rguilayout.wasm",
            "fixed-by": "6d2b057",
            "wrong-code": True,
        }
    },
    "rguistyler": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/rguistyler/rguistyler.wasm",
        }
    },
    "riconpacker": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/riconpacker/riconpacker.wasm",
        }
    },
    "sqlgui": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "6d2b057",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/sqlgui/sqlgui.wasm",
        }
    },
    "commanderkeen": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "bc135ad",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/commanderkeen/commanderkeen.wasm",
        }
    },
    "hydro": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "708ea77",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/hydro/hydro.wasm",
        }
    },
    "rtexviewer": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "708ea77",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/rtexviewer/rtexviewer.wasm",
        }
    },
    "mandelbrot": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "0b43b8",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/mandelbrot/mandelbrot.wasm",
        }
    },
    "pacalc": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "81555ab",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/pacalc/pacalc.wasm",
        }
    },
    "bullet": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "f7aca00",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/bullet/bullet.wasm",
        }
    },
    "sandspiel": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "wrong-code": True,
            "fixed-by": "ccf0c56",
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/sandspiel/sandspiel.wasm",
        }
    },
    "pathfinding": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "ccf0c56",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/pathfinding/pathfinding.wasm",
        }
    },
    "parquet": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "33ec201",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/parquet/parquet.wasm",
        }
    },
    "figma-startpage": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "33ec201",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/figma-startpage/figma-startpage.wasm",
        }
    },
    "ffmpeg": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "4e3e221",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/ffmpeg/ffmpeg.wasm",
        }
    },
    "jqkungfu": {
        "metadata": {
            "origin": "Wasm-R3-Bench",
            "engine": "Wizard",
            "fixed-by": "4e3e221",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/jqkungfu/jqkungfu.wasm",
        }
    },
    "wasmedge#3057": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "WasmEdge",
            "fixed-by": "93fd4ae",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/wasmedge#3057/wasmedge#3057.wasm",
        }
    },
    "wasmedge#3076": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "WasmEdge",
            "fixed-by": "93fd4ae",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/wasmedge#3076/wasmedge#3076.wasm",
        }
    },
    "wamr#2450": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "WAMR",
            "fixed-by": "e360b7",
            "wrong-code": False,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/wamr#2450/wamr#2450.wasm",
        }
    },
    "wasmedge#3019": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "WasmEdge",
            "wrong-code": True,
            "fixed-by": "93fd4ae",
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/wasmedge#3019/wasmedge#3019.wasm",
        }
    },
    "wamr#2789": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "WAMR",
            "wrong-code": False,
            "fixed-by": "718f06",
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/wamr#2789/wamr#2789.wasm",
        }
    },
    "wamr#2862": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "WAMR",
            "fixed-by": "0ee5ff",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/wamr#2862/wamr#2862.wasm",
        }
    },
    "wasmedge#3018": {
        "metadata": {
            "origin": "WASMaker",
            "engine": "WasmEdge",
            "fixed-by": "93fd4ae",
            "wrong-code": True,
            "path": "/workspaces/wasm-r3/evaluation/benchmarks/wasmedge#3018/wasmedge#3018.wasm",
        }
    }
}

testset = [TEST_NAME] if TEST_NAME else start_metrics.keys()

def extract_times(input_string):
    # Define the pattern to match times, including possible timeout
    time_pattern = r"Running (slice-dice|wasm-r3|wasmtime): (\d+)(ms)(\(timeout\))?"

    # Define the pattern to match sliced file size
    size_pattern = r"Sliced file size: (\d+)bytes"

    # Find all matches for times
    time_matches = re.findall(time_pattern, input_string)

    # Find match for sliced file size
    size_match = re.search(size_pattern, input_string)

    # Create a dictionary to store the results
    times = {
        "split-time": "fail",
        "rr-time": "fail",
        "rr-did-timeout": False,
        "sliced_file_size": "fail"
    }

    for match in time_matches:
        key, value, unit, timeout = match
        value = int(value)

        if key == "slice-dice":
            times["split-time"] = value
        elif key == "wasm-r3":
            times["rr-time"] = value
            if timeout:
                times["rr-did-timeout"] = True

    if size_match:
        times["sliced_file_size"] = int(size_match.group(1))

    return times

# Test the function
input_string1 = """wamr#2861-0: Running slice-dice: 25ms Running wasm-r3: 1811ms Sliced file size: 5006bytes"""
input_string2 = """wasmedge#3057-0: Running slice-dice: 345ms Running wasm-r3: 5485ms(timeout) Sliced file size: 39462bytes"""

result1 = extract_times(input_string1)
result2 = extract_times(input_string2)

# Assertions for result1
assert result1["split-time"] == 25, "Split time mismatch in result1"
assert result1["rr-time"] == 1811, "RR time mismatch in result1"
assert result1["sliced_file_size"] == 5006, "Sliced file size mismatch in result1"
assert result1["rr-did-timeout"] == False, "Timeout flag mismatch in result1"

# Assertions for result2
assert result2["split-time"] == 345, "Split time mismatch in result2"
assert result2["rr-time"] == 5485, "RR time mismatch in result2"
assert result2["sliced_file_size"] == 39462, "Sliced file size mismatch in result2"
assert result2["rr-did-timeout"] == True, "Timeout flag mismatch in result2"

wamr_2861_objdump_output = '''====wamr#2861====
  types                                  |        0xa -       0x4b |        65 bytes | 10 count
  functions                              |       0x4d -       0x5b |        14 bytes | 13 count
  tables                                 |       0x5d -       0x64 |         7 bytes | 1 count
  memories                               |       0x66 -       0x6e |         8 bytes | 1 count
  globals                                |       0x70 -       0x7f |        15 bytes | 2 count
  exports                                |       0x82 -      0x155 |       211 bytes | 29 count
  elements                               |      0x157 -      0x15e |         7 bytes | 1 count
  data count                             |      0x160 -      0x161 |         1 bytes | 1 count
  code                                   |      0x164 -      0x32a |       454 bytes | 13 count
       Function index: 0, size: 6 bytes
       Function index: 1, size: 327 bytes
       Function index: 2, size: 5 bytes
       Function index: 3, size: 5 bytes
       Function index: 4, size: 3 bytes
       Function index: 5, size: 5 bytes
       Function index: 6, size: 12 bytes
       Function index: 7, size: 5 bytes
       Function index: 8, size: 5 bytes
       Function index: 9, size: 35 bytes
       Function index: 10, size: 3 bytes
       Function index: 11, size: 12 bytes
       Function index: 12, size: 16 bytes
  data                                   |      0x32d -     0x1889 |      5468 bytes | 1 count
  custom "name"                          |     0x1891 -     0x1924 |       147 bytes | 1 count

'''
def extract_code_bytes(objdump_output):
    lines = objdump_output.split('\n')
    for line in lines:
        if 'code' in line:
            return int(line.split()[6])
assert extract_code_bytes(wamr_2861_objdump_output) == 454

def extract_target_bytes(objdump_output, target_indices):
    lines = objdump_output.split('\n')
    target_bytes = 0
    for line in lines:
        if 'Function index:' in line:
            parts = line.split(',')
            index = int(parts[0].split(':')[1].strip())
            size = int(parts[1].split(':')[1].strip().split()[0])
            if index in target_indices:
                target_bytes += size
    return target_bytes

assert extract_target_bytes(wamr_2861_objdump_output, [1]) == 327

def get_sizes(path):
    module_size = os.path.getsize(path)
    objdump_result = sh(f'wasm-tools objdump {path}')
    code_size = extract_code_bytes(objdump_result)
    # TODO: not hardcode target
    target_indices = [1]
    target_size = extract_target_bytes(objdump_result, target_indices)
    return module_size, code_size, target_size


if __name__ == "__main__":
    if os.path.exists("metrics.json"):
        with open("metrics.json", "r") as f:
            metrics = json.load(f)
    else:
        metrics = {}

    # Update existing metrics with new values
    for key, value in start_metrics.items():
        if key in metrics:
            for sub_key, sub_value in value.items():
                if sub_key in metrics[key]:
                    metrics[key][sub_key].update(sub_value)
                else:
                    metrics[key][sub_key] = sub_value
        else:
            metrics[key] = value

    for key in metrics:
        input_path = metrics[key]["metadata"]["path"]
        module_size, code_size, target_size = get_sizes(input_path)
        metrics[key]['metadata']["module-size"] = module_size
        metrics[key]['metadata']["code-size"] = code_size


    for key in metrics:
        input_path = metrics[key]["metadata"]["path"]
        for tool in ['wasm-slice', 'wasm-hybrid', 'wasm-reduce', 'wasm-shrink']:
            if not metrics[key].get(tool):
                metrics[key][tool] = {}
            oracle_path = testname_to_oracle.get(key, f"{EVAL_PATH}/benchmarks/{key}/oracle.py")
            tool_path = input_path.replace(".wasm", f".{tool_to_suffix[tool]}.wasm")
            oracle_command = f"python {oracle_path} {tool_path}"
            result = subprocess.run(oracle_command, shell=True, check=True)
            if result.returncode == 0:
                module_size, code_size, target_size = get_sizes(tool_path)
                metrics[key][tool]["module-size"] = module_size
                metrics[key][tool]["code-size"] = code_size
                if tool == 'wasm-slice':
                    metrics[key][tool]["target-size"] = target_size
            else:
                raise Exception()
    with open("metrics.json", "w") as f:
        json.dump(metrics, f, indent=4)