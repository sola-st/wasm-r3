import os
import subprocess

r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')

subprocess.run(["python3", os.path.join(r3_path, "evaluation-oopsla2024", "eval-RQ1-1.py")])
subprocess.run(["python3", os.path.join(r3_path, "evaluation-oopsla2024", "eval-RQ1-2.py")])
subprocess.run(["python3", os.path.join(r3_path, "evaluation-oopsla2024", "eval-RQ2-1.py")])
subprocess.run(["python3", os.path.join(r3_path, "evaluation-oopsla2024", "eval-RQ2-2.py")])
subprocess.run(["python3", os.path.join(r3_path, "evaluation-oopsla2024", "eval-RQ3.py")])
subprocess.run(["python3", os.path.join(r3_path, "evaluation-oopsla2024", "eval-RQ4.py")])