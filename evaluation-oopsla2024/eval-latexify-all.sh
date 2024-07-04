#!/bin/bash

r3_path=${WASMR3_PATH:-"/home/wasm-r3"}
python3 $r3_path/evaluation-oopsla2024/eval-RQ1-1,RQ3.py
python3 $r3_path/evaluation-oopsla2024/eval-RQ1-2.py
python3 $r3_path/evaluation-oopsla2024/eval-RQ2-1.py
python3 $r3_path/evaluation-oopsla2024/eval-RQ2-2.py
python3 $r3_path/evaluation-oopsla2024/eval-RQ4.py
python3 $r3_path/evaluation-oopsla2024/latexify.py