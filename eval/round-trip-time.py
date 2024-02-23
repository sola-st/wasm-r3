import json
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
import matplotlib.ticker as ticker

testcases = [
    'boa',
    'commanderkeen',
    'ffmpeg',
    'fib',
    'figma-startpage',
    'funky-kart',
    'game-of-life',
    'guiicons',
    'handy-tools',
    'jsc',
    'kittygame',
    'pathfinding',
    'riconpacker',
    'rtexviewer',
    'sqlgui',
    'video',
    'multiplyInt',
]

# Load data from JSON file
with open('evaluation.json') as f:
    data = json.load(f)

entries = []
for test in testcases:
    entries.append(data[test])
testcases_plus_mean = testcases + ['mean']
testcases_range = range(len(testcases))
testcases_plus_mean_range = range(len(testcases_plus_mean))

# Relative Replay Gen Time Bar Chart
# rg_means = [entry['replayGenTimeMean'] for entry in entries]
# trace_sizes = [entry['traceSize'] for entry in entries]
# relative_rg_means = [a / b for a, b in zip(rg_means, trace_sizes)]
# fig, (ax1, ax2) = plt.subplots(1, 2, gridspec_kw={'width_ratios': [3, 2]}, figsize=(12, 4))
# ax1.bar(testcases_range,
#         relative_rg_means)
# ax1.bar([17], [np.mean(relative_rg_means)], color='orange')
# ax1.set_ylabel('time per event (ms)')
# print('Relative replay gen time standard deviation', np.std(relative_rg_means))
# ax1.set_xticks(testcases_plus_mean_range, testcases_plus_mean,
#                rotation=45, ha='right', fontsize=9)
# ax1.set_xlabel('Web applications')
# # Relative Replay Gen Time Scatter Plot
# ax2.scatter(trace_sizes, relative_rg_means)
# ax2.set_xscale('log')
# ax2.set_xlabel('Trace length')
# # ax2.label_outer()
# ax2.xaxis.set_minor_locator(ticker.NullLocator())
# ax2.grid()

# plt.subplots_adjust(bottom=0.3)
# plt.savefig('rrgt.pdf')
# plt.show()


# Round trip time
# rt_means = [entry['roundTripTimeMean'] for entry in entries]
# rt_means = np.divide(rt_means, 1000)
# plt.bar(testcases_range, rt_means)
# plt.bar([17], [np.mean(rt_means)], color='orange')
# plt.ylabel('Round trip time (s)')
# plt.xticks(testcases_plus_mean_range, testcases_plus_mean,
#            rotation=45, ha='right', fontsize=10)
# plt.xlabel('Web applications')
# plt.subplots_adjust(bottom=0.3)
# plt.savefig('rtt.pdf')
# plt.show()


# Reduction Effectiveness
fig, axs = plt.subplots(3, 6)
i = 0
labels = ['Total', 'Loads', 'Calls', 'Entries']
ran = range(len(labels))
totals = []
raw_traces = []
overall_total_events = []
overall_total_filtered_events = []
load_ratios = []
call_ratios = []
function_entry_ratios = []
for row in axs:
    row[0].set_ylabel('Remaining events (%)', fontsize=8)
    for plot in row:
        if i < 17:
            name = testcases[i]
            stats = data[name]['stats']
            if stats['loadsRatio'] is not None:
                load_ratios.append(stats['loadsRatio'])
            if stats['callsRatio'] is not None:
                call_ratios.append(stats['callsRatio'])
            if stats['functionEntriesRatio'] is not None:
                function_entry_ratios.append(stats['functionEntriesRatio'])
            overall_events = stats['loads'] + stats['tableGets'] + stats['globalGets'] + \
                stats['functionEntries'] + stats['functionExits'] + \
                stats['calls'] + stats['callReturns']
            overall_total_events.append(overall_events)
            overall_filtered_events = stats['relevantLoads'] + stats['relevantTableGets'] + stats['relevantGlobalGets'] + \
                stats['relevantFunctionEntries'] + stats['relevantFunctionExits'] + \
                stats['relevantCalls'] + stats['relevantCallReturns']
            overall_total_filtered_events.append(overall_filtered_events)
            overall_ratio = 0
            if overall_events != 0:
                overall_ratio = overall_filtered_events / overall_events
            totals.append(overall_ratio)
            corrupt_ratios = [overall_ratio, stats['loadsRatio'], stats['callsRatio'],
                              stats['functionEntriesRatio']]
            ratios = [r if r is not None else 0 for r in corrupt_ratios]
            ratios = [r if r != 0 else 0.0001 for r in ratios]
            plot.bar(ran, ratios)
            for index, value in enumerate(corrupt_ratios):
                if value is None or np.isnan(value):
                    plot.text(index, 0.002, "None", color='red',
                              rotation='vertical', ha='center', va='bottom')
        else:
            ratios = [np.mean(totals), data['loadsRatioMean'], data['callsRatioMean'],
                      data['functionEntriesRatioMean']]
            print('Mean Ratios', ratios)
            print('Standard deviations', [np.std(ratios), np.std(
                load_ratios), np.std(call_ratios), np.std(function_entry_ratios)])
            name = 'Mean'
            plot.bar(ran, ratios, color='orange')
        plot.set_title(name, fontsize=8)
        plot.set_yscale('log')
        plot.set_ylim(1e-3, 1)
        plot.yaxis.set_major_formatter(
            mtick.PercentFormatter(xmax=1, decimals=0))
        # plot.yaxis.set_ticks([0, 0.01, 0.1, 1])
        plot.yaxis.set_major_locator(
            ticker.FixedLocator([0.0001, 0.01, 0.1, 1]))
        plot.yaxis.set_minor_locator(ticker.NullLocator())
        plot.set_xticks(ran, labels, rotation=45, ha='right', fontsize=7)
        plot.tick_params(axis='x', which='both', bottom=False, top=False)
        i += 1
for ax in axs.flat:
    ax.label_outer()
plt.savefig('reduction-effectiveness.pdf')
print('overall_filter_ratio', sum(
    overall_total_filtered_events) / sum(overall_total_events))
print('overall_total_events', overall_total_events)
plt.show()
