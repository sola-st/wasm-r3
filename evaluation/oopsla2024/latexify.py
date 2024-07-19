import json, os
import tabulate, scipy.stats, json, numpy as np
import matplotlib.pyplot as plt


r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')
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

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f: metrics = json.load(f)

rq1_results = [['Name', 'URL', 'Domain', 'Success']] + sorted([[testname, testname_to_url_domain[testname][0], testname_to_url_domain[testname][1], 'cmark' if trace_match(metrics, testname) else ''] for testname in metrics])
latex_table = tabulate.tabulate(rq1_results, tablefmt="latex")
latex_table = latex_table.replace('cmark', '\\cmark')
table_2_path = f'{r3_path}/evaluation-oopsla2024/latex/table_2.tex'
with open(table_2_path, 'w') as file:
    file.write(latex_table)
    print(f"Table 2 saved to {table_2_path}")

# RQ 2-1, Figure 9

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f: 
    metrics = json.load(f)
    del metrics['parquet'] # record fails

def get_cycles_slowdown(testname):
    original_cycles = []
    record_cycles = []
    for i in range(10):
        cycles_sum = sum(metrics[testname]['record_metrics']['original'][i]['cycles']) 
        if not cycles_sum > 0:
            print(f"flaky result for original {testname}, {i}th, skipping in geomean calculation")
            continue
        original_cycles.append(cycles_sum)
    for i in range(10):
        cycles_sum = sum(metrics[testname]['record_metrics']['instrumented'][i]['cycles']) 
        if not cycles_sum > 0:
            print(f"flaky result for record {testname}, {i}th, skipping in geomean calculation")
            continue
        record_cycles.append(cycles_sum)
    return scipy.stats.gmean(record_cycles) / scipy.stats.gmean(original_cycles)

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

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f: metrics = json.load(f)
def trace_match(metrics, testname): return metrics[testname]['summary']['trace_match']

data = {}
for testname in metrics:
    if not trace_match(metrics, testname): continue
    try: 
        data[testname] = {}
        data[testname]['instrs_replay_portion'] = metrics[testname]['summary']['instr_dynamic_replay'] / metrics[testname]['summary']['instrs_dynamic_total']
        data[testname]['ticks_replay_portion'] = metrics[testname]['summary']['ticks_replay'] / metrics[testname]['summary']['ticks_total']
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
plt.bar([a for a, b in ticks_replay_portions], [b for a, b in ticks_replay_portions], label='Replay', color='gray')
#plt.xlabel('Test Name')
plt.xticks(rotation=90)
plt.ylabel('Portion')
plt.legend()
figure_10_path = f"{r3_path}/evaluation-oopsla2024/latex/fig_10.pdf"
print(f"Figure 10 saved to {figure_10_path}")
plt.savefig(figure_10_path, bbox_inches='tight') 

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f: metrics = json.load(f)

table_3_path = f'{r3_path}/evaluation-oopsla2024/latex/table_3.tex'
print(f"Table 3 saved to {table_3_path}")

table_4_path = f'{r3_path}/evaluation-oopsla2024/latex/table_4.tex'
print(f"Table 4 saved to {table_4_path}")

# def get_metric(testname, opt, time):
#     metric = metrics[testname]['replay_metrics']['wizeng-int'][opt]
#     if len(metric) == 0:
#         return 0
#     else:
#         return metric[time]

# print('RQ4-1: Load time')
# time = 'load:time_us'
# rq4_results = [['Test name', 'noopt time', 'split time', 'merge time', 'fullopt time']] + [[testname, get_metric(testname, 'noopt', time), get_metric(testname, 'split', time), get_metric(testname, 'merge', time), get_metric(testname, 'benchmark', time)] for testname in metrics if trace_match(metrics, testname)]
# print(tabulate.tabulate(rq4_results, tablefmt="latex"))

# print('RQ4-2: Validate time')
# time = 'validate:time_us'
# rq4_results = [['Test name', 'noopt time', 'split time', 'merge time', 'fullopt time']] + [[testname, get_metric(testname, 'noopt', time), get_metric(testname, 'split', time), get_metric(testname, 'merge', time), get_metric(testname, 'benchmark', time)] for testname in metrics if trace_match(metrics, testname)]
# print(tabulate.tabulate(rq4_results, tablefmt="latex"))

# print('RQ4-3: Main time')
# time = 'main:time_us'
# rq4_results = [['Test name', 'noopt time', 'split time', 'merge time', 'fullopt time']] + [[testname, get_metric(testname, 'noopt', time), get_metric(testname, 'split', time), get_metric(testname, 'merge', time), get_metric(testname, 'benchmark', time)] for testname in metrics if trace_match(metrics, testname)]
# print(tabulate.tabulate(rq4_results, tablefmt="latex"))
