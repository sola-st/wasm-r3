import json, os, math
import tabulate, json, numpy as np
import matplotlib
import matplotlib.pyplot as plt
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42

r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')
METRICS_PATH = '{r3_path}/evaluation-oopsla2024/metrics.json'
os.makedirs(f'{r3_path}/evaluation-oopsla2024/latex', exist_ok=True)

def trace_match(metrics, testname):
    return metrics[testname]['summary']['trace_match']

# RQ 1-1, Table 2

testname_to_url_domain = {
    'bullet': ('https://magnum.graphics/showcase/bullet/', 'Simulator'),
    'factorial': ('https://www.hellorust.com/demos/factorial/index.html', 'Mathematics'),
    'ffmpeg': ('https://w3reality.github.io/async-thread-worker/examples/wasm-ffmpeg/index.html', 'Media'),
    'fractals': ('https://raw-wasm.pages.dev/', 'Graphics'),
    'funky-kart': ('https://www.funkykarts.rocks/demo.html', 'Video game'),
    'game-of-life': ('https://playgameoflife.com/', 'Video game'),
    'gotemplate': ('https://gotemplate.io/', 'Progr. lang.'),
    'hnset-bench': ('https://raw.githack.com/gorhill/uBlock/master/docs/tests/hnset-benchmark.html', 'Benchmark'),
    'hydro': ('https://cselab.github.io/aphros/wasm/hydro.html', 'Simulator'),
    'jqkungfu': ('http://jqkungfu.com/', 'Progr. lang.'),
    'lichess': ('https://lichess.org/analysis', 'Video game'),
    'mandelbrot': ('http://whealy.com/Rust/mandelbrot.html', 'Graphics'),
    'ogv': ('https://brionv.com/misc/ogv.js/demo/', 'Media'),
    'onnxjs': ('https://microsoft.github.io/onnxjs-demo/#/', 'Machine learning'),
    'pacalc': ('http://whealy.com/acoustics/PA_Calculator/index.html', 'Mathematics'),
    'parquet': ('https://google.github.io/filament/webgl/parquet.html', 'Graphics'),
    'playnox': ('https://playnox.xyz/', 'Video game'),
    'roslyn': ('http://roslynquoter-wasm.platform.uno/', 'Progr. lang.'),
    'rustpython': ('https://rustpython.github.io/demo/', 'Progr. lang.'),
    'sandspiel': ('https://sandspiel.club/', 'Video game'),
    'sqlgui': ('http://kripken.github.io/sql.js/examples/GUI/', 'Progr. lang.'),
    'sqlpractice': ('https://www.sql-practice.com', 'Progr. lang.'),
    'takahirox': ('https://takahirox.github.io/WebAssembly-benchmark/', 'Benchmark'),
    'fib': ('https://takahirox.github.io/WebAssembly-benchmark/tests/fib.html', 'Benchmark'),
    'multiplyInt': ('https://takahirox.github.io/WebAssembly-benchmark/tests/multiplyInt.html', 'Benchmark'),
    'multiplyDouble': ('https://takahirox.github.io/WebAssembly-benchmark/tests/multiplyDouble.html', 'Benchmark'),
    'image-convolute': ('https://takahirox.github.io/WebAssembly-benchmark/tests/imageConvolute.html', 'Benchmark'),
    'tic-tac-toe': ('https://sepiropht.github.io/tic-tac-toe-wasm/', 'Video game'),
    'timestretch': ('https://superpowered.com/js-wasm-sdk/example_timestretching/', 'Media'),
    'waforth': ('https://el-tramo.be/waforth', 'Progr. lang.'),
    'wasmsh': ('https://webassembly.sh/', 'Utility'),
    'wheel': ('https://boyan.io/wasm-wheel/', 'Benchmark'),
    'guiicons': ('https://raylibtech.itch.io/rguiicons', 'Utility'),
    'riconpacker': ('https://raylibtech.itch.io/riconpacker', 'Utility'),
    'rtexviewer': ('https://raylibtech.itch.io/rtexviewer', 'Utility'),
    'boa': ('https://boajs.dev/boa/playground/', 'Progr. lang.'),
    'commanderkeen': ('https://www.jamesfmackenzie.com/chocolatekeen', 'Video game'),
    'figma-startpage': ('https://www.figma.com', 'Graphics'),
    'jsc': ('https://mbbill.github.io/JSC.js/demo/index.html', 'Progr. lang.'),
    'pathfinding': ('https://jacobdeichert.github.io/wasm-astar/', 'Benchmark'),
    'livesplit': ('https://one.livesplit.org/', 'Utility'),
    'rfxgen': ('https://raylibtech.itch.io/rfxgen', 'Utility'),
    'rguilayout': ('https://raylibtech.itch.io/rguilayout', 'Utility'),
    'rguistyler': ('https://raylibtech.itch.io/rguistyler', 'Utility'),
    'rtexpacker': ('https://raylibtech.itch.io/rtexpacker', 'Utility'),
}

with open(f'{METRICS_PATH}', 'r') as f: metrics = json.load(f)

rq1_results = [['Name', 'URL', 'Domain', 'Success']] + sorted([[testname, testname_to_url_domain[testname][0], testname_to_url_domain[testname][1], 'cmark' if trace_match(metrics, testname) else ''] for testname in metrics])
latex_table = tabulate.tabulate(rq1_results, tablefmt="latex")
latex_table = latex_table.replace('cmark', '\\cmark')
table_2_path = f'{r3_path}/evaluation-oopsla2024/latex/table_2.tex'
with open(table_2_path, 'w') as file:
    file.write(latex_table)
    print(f"Table 2 saved to {table_2_path}")

# RQ 2-1, Figure 9

with open(f'{METRICS_PATH}', 'r') as f: 
    metrics = json.load(f)
    del metrics['parquet'] # record fails

def get_cycles_slowdown(testname):
    original_cycles = []
    record_cycles = []
    for i in range(10):
        cycles_sum = sum(metrics[testname]['record_metrics']['original'][i]['cycles']) 
        if not cycles_sum > 0:
            # print(f"flaky result for original {testname}, {i}th, skipping in geomean calculation")
            continue
        original_cycles.append(cycles_sum)
    for i in range(10):
        cycles_sum = sum(metrics[testname]['record_metrics']['instrumented'][i]['cycles']) 
        if not cycles_sum > 0:
            # print(f"flaky result for record {testname}, {i}th, skipping in geomean calculation")
            continue
        record_cycles.append(cycles_sum)
    return np.mean(record_cycles) / np.mean(original_cycles)

table = sorted([(testname, get_cycles_slowdown(testname)) for testname in metrics if trace_match(metrics, testname)], key=lambda x: x[1], reverse=True)

plt.figure()
testname_gmean_pairs = [(row[0], row[-1]) for row in table]
testname_gmean_pairs.sort(key=lambda pair: pair[1], reverse=True)
gmean_values = [pair[1] for pair in testname_gmean_pairs]
test_names = [pair[0] for pair in testname_gmean_pairs]
plt.figure(figsize=(10,4))
plt.tight_layout()
plt.xlim(-0.5, 26.5)
plt.bar(test_names, gmean_values, label='Geometric Mean', color='gray')
plt.xticks(rotation=90)
plt.yticks(list(range(int(min(gmean_values)), int(max(gmean_values)) + 1, 4)) + [1])
plt.ylabel('CPU Cycles Slowdown')
plt.plot([-1, 29], [1, 1], linestyle='dashed', color='black')
figure_9_path = f"{r3_path}/evaluation-oopsla2024/latex/fig_9.pdf"
print(f"Figure 9 saved to {figure_9_path}")
plt.savefig(figure_9_path, bbox_inches='tight')

# RQ 2-2, Figure 10

with open(f'{METRICS_PATH}', 'r') as f: metrics = json.load(f)
def trace_match(metrics, testname): return metrics[testname]['summary']['trace_match']

data = {}
for testname in metrics:
    if not trace_match(metrics, testname): continue
    try: 
        data[testname] = {}
        ticks = metrics[testname]['ticks']
        data[testname]['instrs_replay_portion'] = sum(o['instr_dynamic_replay'] for o in ticks) / sum(o['instrs_dynamic_total'] for o in ticks)
        data[testname]['ticks_replay_portion'] = sum(o['ticks_replay'] for o in ticks) / sum(o['ticks_total'] for o in ticks)
    except Exception as e:
        del data[testname]
        print(f"Error in {testname}: {e}")

# Plot the portions
instrs_replay_portions = [[testname, data[testname]['instrs_replay_portion']] for testname in data]
instrs_replay_portions.sort(key=lambda x: x[1], reverse=True)
ticks_replay_portions = [[testname, data[testname]['ticks_replay_portion']] for testname in data]
ticks_replay_portions.sort(key=lambda x: x[1], reverse=True)

plt.figure(figsize=(10, 3))
plt.xlim(-0.5, 27.5)
plt.ylim(0, 1)
plt.bar([a for a, b in ticks_replay_portions], [1]*len(ticks_replay_portions),
        label='Original', color='lightgrey')
plt.bar([a for a, b in ticks_replay_portions], [b for a, b in ticks_replay_portions], label='Replay', color='red')
#plt.xlabel('Test Name')
plt.xticks(rotation=90)
plt.ylabel('Portion')
plt.legend()
figure_10_path = f"{r3_path}/evaluation-oopsla2024/latex/fig_10.pdf"
print(f"Figure 10 saved to {figure_10_path}")
plt.savefig(figure_10_path, bbox_inches='tight') 

with open(f'{METRICS_PATH}', 'r') as f: metrics = json.load(f)

import json
from tabulate import tabulate

def process_json_data(data):
    try: 
        summary = data['summary']
        
        total_events = (
            summary['loads'] +
            summary['tableGets'] +
            summary['globalGets'] +
            summary['functionEntries'] +
            summary['functionExits'] +
            summary['calls'] +
            summary['callReturns']
        )
        
        shadow_opt_events = (
            summary['relevantLoads'] +
            summary['relevantTableGets'] +
            summary['relevantGlobalGets'] +
            summary['functionEntries'] +
            summary['functionExits'] +
            summary['calls'] +
            summary['callReturns']
        )
        
        call_stack_opt_events = (
            summary['loads'] +
            summary['tableGets'] +
            summary['globalGets'] +
            summary['relevantFunctionEntries'] +
            summary['relevantFunctionExits'] +
            summary['relevantCalls'] +
            summary['relevantCallReturns']
        )
        
        all_opt_events = (
            summary['relevantLoads'] +
            summary['relevantTableGets'] +
            summary['relevantGlobalGets'] +
            summary['relevantFunctionEntries'] +
            summary['relevantFunctionExits'] +
            summary['relevantCalls'] +
            summary['relevantCallReturns']
        )
        
        shadow_opt = shadow_opt_events / total_events * 100
        call_stack_opt = call_stack_opt_events / total_events * 100
        all_opt = all_opt_events / total_events * 100
        
        return [
            total_events,
            shadow_opt,
            call_stack_opt,
            all_opt
        ]
    except Exception as e:
        return None

# Process the data
data = []
for name, content in metrics.items():
    result = process_json_data(content)
    if result is not None:
        row = [name] + result
        data.append(row)
# Define headers
headers = [
    "Name",
    "Trace (# Events)\nNo-opt",
    "Shadow-opt",
    "Call-stack-opt",
    "All-opt"
]

# Generate the table
table = tabulate(data, headers, tablefmt="pipe", floatfmt=".2f")

table_3_path = f'{r3_path}/evaluation-oopsla2024/latex/table_3.tex'
with open(table_3_path, 'w') as f:
    f.write(table)
print(f"Table 3 saved to {table_3_path}")

with open(f'{METRICS_PATH}', 'r') as f: metrics = json.load(f)

def process_replay_metrics(data):
    results = {}
    for benchmark, benchmark_data in data.items():
        if 'replay_metrics' not in benchmark_data or 'wizeng-int' not in benchmark_data['replay_metrics']:
            continue
        
        data = benchmark_data['replay_metrics']['wizeng-int']
        load_validation_times = {
            'noopt': [],
            'split': [],
            'merge': [],
            'benchmark': []
        }
        execution_times = {
            'noopt': [],
            'split': [],
            'merge': [],
            'benchmark': []
        }

        for opt in ['noopt', 'split', 'merge', 'benchmark']:
            if opt not in data:
                continue
            for entry in data[opt]:
                load_validation_time = float(entry['load:time_us']) + float(entry['validate:time_us'])
                execution_time = float(entry['main:time_us'])
                load_validation_times[opt].append(load_validation_time)
                execution_times[opt].append(execution_time)
        
        if any(not times for times in load_validation_times.values()) or any(not times for times in execution_times.values()):
            continue

        avg_load_validation = {opt: sum(times) / len(times) for opt, times in load_validation_times.items()}
        avg_execution = {opt: sum(times) / len(times) for opt, times in execution_times.items()}

        results[benchmark] = {
            'load_validation': avg_load_validation,
            'execution': avg_execution
        }

    return results


def calculate_percentages(base, values):
    return [value / base * 100 for value in values]

processed_data = process_replay_metrics(metrics)

# Prepare table data
table_data = []
for name, metrics in processed_data.items():
    load_validation_base = metrics['load_validation']['noopt']
    load_validation_percentages = calculate_percentages(
        load_validation_base,
        [metrics['load_validation'][opt] for opt in ['split', 'merge', 'benchmark']]
    )

    execution_base = metrics['execution']['noopt']
    execution_percentages = calculate_percentages(
        execution_base,
        [metrics['execution'][opt] for opt in ['split', 'merge', 'benchmark']]
    )

    row = [
        name,
        load_validation_base,
        *load_validation_percentages,
        execution_base,
        *execution_percentages
    ]
    table_data.append(row)

# Calculate geometric mean
geomean_load_validation = [
    math.prod([row[i] for row in table_data]) ** (1 / len(table_data))
    for i in range(2, 5)
]
geomean_execution = [
    math.prod([row[i] for row in table_data]) ** (1 / len(table_data))
    for i in range(6, 9)
]

table_data.append([
    "Geomean",
    "",
    *geomean_load_validation,
    "",
    *geomean_execution
])

# Define headers
headers = [
    "Name",
    "Load+Validation time (μs)\nNo",
    "Split",
    "Merge",
    "All",
    "Execution time (μs)\nNo",
    "Split",
    "Merge",
    "All"
]

# Generate the table
table = tabulate(table_data, headers, tablefmt="latex_booktabs", floatfmt=(".1f", ".1f", ".2f", ".2f", ".2f", ".1f", ".2f", ".2f", ".2f"))

# Add LaTeX table environment and caption
latex_table = f"""
\\begin{{table}}[t]
\\footnotesize
  \\caption{{Replay optimization experiment results.}}
  \\label{{t:replay}}
{table}
\\end{{table}}
"""

table_4_path = f'{r3_path}/evaluation-oopsla2024/latex/table_4.tex'

# Save the LaTeX table to a file
with open(table_4_path, 'w') as f:
    f.write(latex_table)

print(f"Table 4 saved to {table_4_path}")