// Import the file system module with promises
import { readFile } from 'fs/promises';
import {createObjectCsvWriter } from 'csv-writer'

async function parseJSONFromFile(filePath) {
  try {
    const jsonString = await readFile(filePath, { encoding: 'utf8' });
    const obj = JSON.parse(jsonString);
    //console.log("JSON file has been parsed into an object:", obj); 
    return obj;
  } catch (err) {
    console.error("Error reading or parsing the file:", err);
  }
}

const metric = await parseJSONFromFile('metrics.json');

const names = Object.keys(metric)
console.log(names)
//console.log(metric[names[1]])

// 0. Evaluation set info
const evalset_writer = createObjectCsvWriter({
  path: 'evalset.csv',
  header: [
    { id: 'name', title: 'Name'},
    { id: 'instr_count', title: 'Instruction'}
  ]
})

const evalset_data = []
for (const name of names) {
  let data_obj = {name: name}
  //console.log(name)
  const obj = metric[name]
  const summ = obj['summary']  
  const instr_total = summ['instr_static_total']
  const instr_replay = summ['instr_static_replay']
  const instr_orig = instr_total - instr_replay
  if (!isNaN(instr_orig)) { data_obj['instr_count'] = instr_orig }
  //console.log(data_obj)
  evalset_data.push(data_obj)
}
//console.log(evalset_data)


evalset_writer.writeRecords(evalset_data).
  then(() => {
    console.log('evalset write done')
  });

// RQ1. Applicability
// 1.1. Accuracy expr
const acc_writer = createObjectCsvWriter({
  path: 'rq1_accuracy.csv',
  header: [
    { id : 'name', title: 'Name'},
    { id : 'match', title: 'Trace Match'}
  ]
})

const acc_data = []
for (const name of names) {
  let data_obj = {name: name}
  const obj = metric[name]
  const summ = obj['summary']
  const trace_match = summ['trace_match'] 
  if (trace_match) {
    data_obj['match'] = 'o'
  }
  else {
    data_obj['match'] = 'x'
  }
  acc_data.push(data_obj)
}

acc_writer.writeRecords(acc_data).
  then(()=> {
    console.log('accuracy write done')
  })


// 1.2. Portabiltiy expr
// portability - web
const port_web_writer = createObjectCsvWriter({
  path: 'rq1_port_web.csv',
  header: [
    {id: 'name', title: 'Name'},
    {id: 'sm', title: 'sm'},
    {id: 'sm-base', title: 'sm-base'},
    {id: 'sm-opt', title: 'sm-opt'},
    {id: 'v8', title: 'v8'},
    {id: 'v8-liftoff', title: 'v8-liftoff'},
    {id: 'v8-turbofan', title: 'v8-turbofan'},
    {id: 'jsc', title: 'jsc'},
    {id: 'jsc-int', title: 'jsc-int'},
    {id: 'jsc-bbq', title: 'jsc-bbq'},
    {id: 'jsc-omg', title: 'jsc-omg'}
  ] 
})

// portability - standalones
const port_wasm_writer = createObjectCsvWriter({
  path: 'rq1_port_wasm.csv',
  header: [
    {id: 'name', title: 'Name'},
    {id: 'wiz', title: 'wiz'},
    {id: 'wiz-jit', title: 'wiz-jit'},
    {id: 'wiz-dyn', title: 'wiz-dyn'},
    {id: 'wasmtime', title: 'wasmtime'},
    {id: 'wasmer', title: 'wasmer'},
    {id: 'wasmer-base', title: 'wasmer-base'},
  ] 
})

const port_web_data = []
const port_wasm_data = []
for (const name of names) {
  let data_web = {name: name}   
  let data_wasm = {name: name}
  const obj = metric[name]
  const rep_met = obj['replay_metrics']
  if (rep_met === undefined) continue

  try {
    data_web['sm'] = rep_met['sm']['benchmark']['runtime']
    data_web['sm-base'] = rep_met['sm-base']['benchmark']['runtime']

    data_web['sm-opt'] = rep_met['sm-opt']['benchmark']['runtime']
    data_web['v8'] = rep_met['v8']['benchmark']['runtime']
    data_web['v8-liftoff'] = rep_met['v8-liftoff']['benchmark']['runtime']
    data_web['v8-turbofan'] = rep_met['v8-turbofan']['benchmark']['runtime']
    data_web['jsc'] = rep_met['jsc']['benchmark']['runtime']
    data_web['jsc-int'] = rep_met['jsc-int']['benchmark']['runtime']
    data_web['jsc-bbq'] = rep_met['jsc-bbq']['benchmark']['runtime']
    data_web['jsc-omg'] = rep_met['jsc-omg']['benchmark']['runtime']

    data_wasm['wiz'] = rep_met['wizeng']['benchmark']['runtime']
    data_wasm['wiz-jit'] = rep_met['wizeng-jit']['benchmark']['runtime']
    data_wasm['wiz-dyn'] = rep_met['wizeng-dyn']['benchmark']['runtime']
    data_wasm['wasmtime'] = rep_met['wasmtime']['benchmark']['runtime']
    data_wasm['wasmer'] = rep_met['wasmer']['benchmark']['runtime']
    data_wasm['wasmer-base'] = rep_met['wasmer-base']['benchmark']['runtime']
  } catch (e) {
    continue
  }

  port_web_data.push(data_web)
  port_wasm_data.push(data_wasm)
}

port_web_writer.writeRecords(port_web_data).
  then(() => {
    console.log('portability-web write done')
  });
port_wasm_writer.writeRecords(port_wasm_data).
  then(() => {
    console.log('portability-wasm write done')
  });


// RQ2. Performance
// 2.1. Record overhead



// 2.2. Replay charateristic



// RQ3. Trace reduction effectiveness
const reduce_writer = createObjectCsvWriter({
  path: 'reduce_ablation.csv',
  header: [
    { id: 'name', title: 'Name'},
    { id: 'noopt', title: 'No-opt'},
    { id: 'shadow', title: 'Shadow-opt'},
    { id: 'shadow-perc', title: 'Shadow-opt-perc'},
    { id: 'callstack', title: 'Call-stack-opt'},
    { id: 'callstack-perc', title: 'Call-stack-opt-perc'},
    { id: 'opt', title: 'All-opt'},
    { id: 'opt-perc', title: 'All-opt-perc'},
  ]
})

function opt_percent(original, optimized) { 
  return (optimized)/(original)  
}

function opt_delta_percent(original, optimized) { 
  return (optimized-original)/(original)  
}



const reduce_data = []
for (const name of names) {
  let data_obj = {name: name}
  //console.log(name)
  const obj = metric[name]
  const summ = obj['summary']  
  if (!summ['trace_match']) continue
  const noopt_trace = 
    summ['loads'] + summ['tableGets'] + summ['globalGets'] 
    + summ['functionEntries'] + summ['functionExits']
    + summ['calls'] + summ['callReturns']
  const shadow_trace = 
    summ['relevantLoads'] + summ['relevantTableGets'] + summ['relevantGlobalGets'] 
    + summ['functionEntries'] + summ['functionExits']
    + summ['calls'] + summ['callReturns']
  const callstack_trace = 
    summ['loads'] + summ['tableGets'] + summ['globalGets'] 
    + summ['relevantFunctionEntries'] + summ['relevantFunctionExits']
    + summ['relevantCalls'] + summ['relevantCallReturns']
  const opt_trace = 
    summ['relevantLoads'] + summ['relevantTableGets'] + summ['relevantGlobalGets'] 
    + summ['relevantFunctionEntries'] + summ['relevantFunctionExits']
    + summ['relevantCalls'] + summ['relevantCallReturns']

  data_obj['noopt'] = noopt_trace
  data_obj['shadow'] = shadow_trace 
  data_obj['callstack'] = callstack_trace
  data_obj['opt'] = opt_trace

  data_obj['shadow-perc'] = opt_percent(noopt_trace, shadow_trace) 
  data_obj['callstack-perc'] = opt_percent(noopt_trace, callstack_trace) 
  data_obj['opt-perc'] = opt_percent(noopt_trace, opt_trace) 

  reduce_data.push(data_obj)
}

reduce_writer.writeRecords(reduce_data).
  then(() => {
    console.log('reduce write done')
  });


// RQ4. Replay optimization effectiveness
const replayopt_byte_writer = createObjectCsvWriter({
  path: 'replayopt_byte_ablation.csv',
  header: [
    { id: 'name', title: 'Name'},
    { id: 'noopt', title: 'No-opt'},
    { id: 'split', title: 'Split'},
    { id: 'split-perc', title: 'Split-perc'},
    { id: 'merge', title: 'Merge'},
    { id: 'merge-perc', title: 'Merge-perc'},
    { id: 'opt', title: 'opt'},
    { id: 'opt-perc', title: 'opt-perc'},
  ]
})

const replayopt_time_writer = createObjectCsvWriter({
  path: 'replayopt_time_ablation.csv',
  header: [
    { id: 'name', title: 'Name'},
    { id: 'noopt-pre', title: 'No-opt-pre'},
    { id: 'split-pre', title: 'Split-pre'},
    { id: 'split-pre-perc', title: 'Split-pre-perc'},
    { id: 'merge-pre', title: 'Merge-pre'},
    { id: 'merge-pre-perc', title: 'Merge-pre-perc'},
    { id: 'opt-pre', title: 'opt-pre'},
    { id: 'opt-pre-perc', title: 'opt-pre-perc'},

    { id: 'noopt-main', title: 'No-opt-main'},
    { id: 'split-main', title: 'Split-main'},
    { id: 'split-main-perc', title: 'Split-main-perc'},
    { id: 'merge-main', title: 'Merge-main'},
    { id: 'merge-main-perc', title: 'Merge-main-perc'},
    { id: 'opt-main', title: 'opt-main'},
    { id: 'opt-main-perc', title: 'opt-main-perc'},


  ]
})

const replayopt_loadtime_writer = createObjectCsvWriter({
  path: 'replayopt_loadtime_ablation.csv',
  header: [
    { id: 'name', title: 'Name'},
    { id: 'noopt', title: 'No-opt'},
    { id: 'split', title: 'Split'},
    { id: 'split-perc', title: 'Split-perc'},
    { id: 'merge', title: 'Merge'},
    { id: 'merge-perc', title: 'Merge-perc'},
    { id: 'opt', title: 'opt'},
    { id: 'opt-perc', title: 'opt-perc'},
  ]
})


const replayopt_comptime_writer = createObjectCsvWriter({
  path: 'replayopt_comptime_ablation.csv',
  header: [
    { id: 'name', title: 'Name'},
    { id: 'noopt', title: 'No-opt'},
    { id: 'split', title: 'Split'},
    { id: 'split-perc', title: 'Split-perc'},
    { id: 'merge', title: 'Merge'},
    { id: 'merge-perc', title: 'Merge-perc'},
    { id: 'opt', title: 'opt'},
    { id: 'opt-perc', title: 'opt-perc'},
  ]
})

const replayopt_maintime_writer = createObjectCsvWriter({
  path: 'replayopt_maintime_ablation.csv',
  header: [
    { id: 'name', title: 'Name'},
    { id: 'noopt', title: 'No-opt'},
    { id: 'split', title: 'Split'},
    { id: 'split-perc', title: 'Split-perc'},
    { id: 'merge', title: 'Merge'},
    { id: 'merge-perc', title: 'Merge-perc'},
    { id: 'opt', title: 'opt'},
    { id: 'opt-perc', title: 'opt-perc'},
  ]
})



const replayopt_byte_data = []
const replayopt_loadtime_data = []
const replayopt_comptime_data = []
const replayopt_maintime_data = []

for (const name of names) {
  let byte_data = {name: name}
  let loadtime_data = {name: name}
  let comptime_data = {name: name}
  let maintime_data = {name: name}
  //console.log(name)
  const obj = metric[name]
  const summ = obj['summary']
  if (!summ['trace_match']) continue
  const wizmet = obj['replay_metrics']['wizeng-int']
  const noopt = wizmet['noopt'] 
  const split = wizmet['split'] 
  const merge = wizmet['merge'] 
  const opt = wizmet['benchmark'] 

  try{
    const noopt_bytes = Number(noopt['load:bytes'].replace('bytes', '')) 
    const split_bytes = Number(split['load:bytes'].replace('bytes', ''))
    const merge_bytes = Number(merge['load:bytes'].replace('bytes', ''))
    const opt_bytes = Number(opt['load:bytes'].replace('bytes', ''))

    byte_data['noopt'] = noopt_bytes
    byte_data['split'] = split_bytes 
    byte_data['merge'] = merge_bytes 
    byte_data['opt'] = opt_bytes 
    
    byte_data['split-perc'] = opt_percent(noopt_bytes, split_bytes)
    byte_data['merge-perc'] = opt_percent(noopt_bytes, merge_bytes)
    byte_data['opt-perc'] = opt_percent(noopt_bytes, opt_bytes)

    const noopt_load_time = Number(noopt['load:time_us'])  
    const split_load_time = Number(split['load:time_us'])  
    const merge_load_time = Number(merge['load:time_us'])   
    const opt_load_time = Number(opt['load:time_us']) 

    const noopt_comp_time = Number(noopt['validate:time_us'])  
    const split_comp_time = Number(split['validate:time_us'])  
    const merge_comp_time = Number(merge['validate:time_us'])   
    const opt_comp_time = Number(opt['validate:time_us'])  

    const noopt_main_time = Number(noopt['main:time_us']) 
    const split_main_time = Number(split['main:time_us']) 
    const merge_main_time = Number(merge['main:time_us']) 
    const opt_main_time = Number(opt['main:time_us']) 

    loadtime_data['noopt'] = noopt_load_time
    loadtime_data['split'] = split_load_time
    loadtime_data['merge'] = merge_load_time
    loadtime_data['opt'] = opt_load_time

    comptime_data['noopt'] = noopt_comp_time
    comptime_data['split'] = split_comp_time
    comptime_data['merge'] = merge_comp_time
    comptime_data['opt'] = opt_comp_time
    
    maintime_data['noopt'] = noopt_main_time
    maintime_data['split'] = split_main_time
    maintime_data['merge'] = merge_main_time
    maintime_data['opt'] = opt_main_time



    loadtime_data['split-perc'] = opt_percent(noopt_load_time, split_load_time)
    loadtime_data['merge-perc'] = opt_percent(noopt_load_time, merge_load_time)
    loadtime_data['opt-perc'] = opt_percent(noopt_load_time, opt_load_time)

    comptime_data['split-perc'] = opt_percent(noopt_comp_time, split_comp_time)
    comptime_data['merge-perc'] = opt_percent(noopt_comp_time, merge_comp_time)
    comptime_data['opt-perc'] = opt_percent(noopt_comp_time, opt_comp_time)

    maintime_data['split-perc'] = opt_percent(noopt_main_time, split_main_time)
    maintime_data['merge-perc'] = opt_percent(noopt_main_time, merge_main_time)
    maintime_data['opt-perc'] = opt_percent(noopt_main_time, opt_main_time)


    replayopt_byte_data.push(byte_data)
    replayopt_loadtime_data.push(loadtime_data)
    replayopt_comptime_data.push(comptime_data)
    replayopt_maintime_data.push(maintime_data)
  }
  catch (e) { continue }
}


replayopt_byte_writer.writeRecords(replayopt_byte_data).
  then(() => {
    console.log('replay opt byte write done')
  });

replayopt_loadtime_writer.writeRecords(replayopt_loadtime_data).
  then(() => {
    console.log('replay opt loadtime write done')
  });
replayopt_comptime_writer.writeRecords(replayopt_comptime_data).
  then(() => {
    console.log('replay opt comptime write done')
  });
replayopt_maintime_writer.writeRecords(replayopt_maintime_data).
  then(() => {
    console.log('replay opt maintime write done')
  });
