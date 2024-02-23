import { WriteStream } from "fs";
import {
  ReplayToWriteStream,
  Result,
  Store,
  Call,
  TableCall,
  MemGrow,
  TableSet,
  TableGrow,
  GlobalSet,
  Context,
} from "./replay-generator.cjs";
import { unreachable } from "./util.cjs";

export const generateJavascript: ReplayToWriteStream = async (stream, code) => {
//   stream.write(`import fs from 'fs'\n`);
//   stream.write(`import path from 'path'\n`);
  stream.write(`let instance\n`);
  stream.write("let imports = {}\n");

  // Init modules
  for (let module of code.modules) {
    stream.write(`${writeModule(module)}\n`);
  }
  // Init memories
  for (let memidx in code.memImports) {
    let mem = code.memImports[memidx];
    stream.write(
      `const ${mem.name} = new WebAssembly.Memory({ initial: ${mem.initial}, maximum: ${mem.maximum} })\n`
    );
    stream.write(`${writeImport(mem.module, mem.name)}${mem.name}\n`);
  }
  // Init globals
  for (let globalIdx in code.globalImports) {
    let global = code.globalImports[globalIdx];
    // There is a special case here:
    // you can also import the values NaN and Infinity as globals in WebAssembly
    // Thats why whe need this if else
    if (Number.isNaN(global.initial) || !Number.isFinite(global.initial)) {
      if (global.name.toLocaleLowerCase() === "infinity") {
        stream.write(`${writeImport(global.module, global.name)}Infinity\n`);
      } else if (global.name.toLocaleLowerCase() === "nan") {
        stream.write(`${writeImport(global.module, global.name)}NaN\n`);
      } else {
        throw new Error(
          `Could not generate javascript code for the global initialisation, the initial value is NaN. The website you where recording did some weired stuff that I was not considering during the implementation of Wasm-R3. Tried to genereate global ${global}`
        );
      }
    } else {
      stream.write(
        `const ${global.name} = new WebAssembly.Global({ value: '${global.value}', mutable: ${global.mutable}}, ${global.initial})\n`
      );
      stream.write(
        `${writeImport(global.module, global.name)}${global.name}\n`
      );
    }
  }
  // Init tables
  for (let tableidx in code.tableImports) {
    let table = code.tableImports[tableidx];
    stream.write(
      `const ${table.name} = new WebAssembly.Table({ initial: ${table.initial}, maximum: ${table.maximum}, element: '${table.element}'})\n`
    );
    stream.write(`${writeImport(table.module, table.name)}${table.name}\n`);
  }
  // Imported functions
  for (let funcidx in code.funcImports) {
    stream.write(`let ${writeFuncGlobal(funcidx)} = -1\n`);
    let func = code.funcImports[funcidx];
    stream.write(`${writeImport(func.module, func.name)}() => {\n`);
    stream.write(`${writeFuncGlobal(funcidx)}++\n`);
    if (func.bodys.length !== 0) {
      stream.write(`switch (${writeFuncGlobal(funcidx)}) {\n`);
      for (let i = 0; i < func.bodys.length; i++) {
        await writeBody(stream, func.bodys[i], i);
      }
      stream.write("}\n");
    }
    await writeResults(stream, func.results, writeFuncGlobal(funcidx));
    stream.write("}\n");
  }
  stream.write(`export function replay(wasm) {`);
  stream.write(`instance = wasm.instance\n`);
  for (let exp of code.calls) {
    stream.write(
      `instance.exports.${exp.name}(${writeParamsString(exp.params)}) \n`
    );
  }
  // Init entity states
  for (let event of code.initialization) {
    switch (event.type) {
      case "Store":
        await write(stream, storeEvent(event));
        break;
      case "MemGrow":
        await write(stream, memGrowEvent(event));
        break;
      case "TableSet":
        await write(stream, tableSetEvent(event));
        break;
      case "TableGrow":
        await write(stream, tableGrowEvent(event));
        break;
      case "Call":
        await write(stream, callEvent(event));
        break;
      case "TableCall":
        await write(stream, tableCallEvent(event));
        break;
      case "GlobalSet":
        await write(stream, globalSet(event));
        break;
      default:
        unreachable(event);
    }
  }

  stream.write(`}\n`);
  stream.write(`export function instantiate(wasmBinary) {\n`);
  stream.write(`return WebAssembly.instantiate(wasmBinary, imports)\n`);
  stream.write(`}\n`);
  stream.write('let firstArg\n')
  stream.write(
    "if (typeof Deno === 'undefined'){firstArg=process.argv[2]}else{firstArg=Deno.args[0]}\n"
  );
  stream.write("if (firstArg === 'run') {\n");
  stream.write("let nodeModules;\n");
  stream.write(
    "if (typeof Deno === 'undefined') { nodeModules = Promise.all([import('path'),import('fs')])}else{nodeModules=Promise.all([import('node:path'),import('node:fs')])}\n"
  );
  stream.write("nodeModules.then(([path,fs])=>{");
  stream.write(
    `const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n`
  );
  stream.write(`const wasmBinary = fs.readFileSync(p)\n`);
  stream.write(`instantiate(wasmBinary).then((wasm) => replay(wasm))\n`);
  stream.write(`})}\n`);
  stream.close();
};

async function writeBody(stream: WriteStream, b: Context, i: number) {
  if (b.length !== 0) {
    await write(stream, `case ${i}:\n`);
    for (let event of b) {
      switch (event.type) {
        case "Call":
          await write(stream, callEvent(event));
          break;
        case "TableCall":
          await write(stream, tableCallEvent(event));
          break;
        case "Store":
          await write(stream, storeEvent(event));
          break;
        case "MemGrow":
          await write(stream, memGrowEvent(event));
          break;
        case "TableSet":
          await write(stream, tableSetEvent(event));
          break;
        case "TableGrow":
          await write(stream, tableGrowEvent(event));
          break;
        case "GlobalSet":
          await write(stream, globalSet(event));
          break;
        default:
          unreachable(event);
      }
    }
    stream.write(`break\n`);
  }
}

async function writeResults(
  stream: WriteStream,
  results: Result[],
  funcGlobal: string
) {
  let current = 0;
  for (let r of results) {
    const newC = current + r.reps;
    stream.write(
      `if ((${funcGlobal} >= ${current}) && ${funcGlobal} < ${newC}) {\n`
    );
    stream.write(`return ${r.results[0]} }\n`);
    current = newC;
  }
}

async function write(stream: WriteStream, s: string) {
  if (stream.write(s) === false) {
    await new Promise((resolve) => stream.once("drain", resolve));
  }
}

function storeEvent(event: Store) {
  let jsString = "";
  event.data.forEach((byte, j) => {
    event = event as Store;
    if (event.import) {
      jsString += `new Uint8Array(${event.name}.buffer)[${
        event.addr + j
      }] = ${byte}\n`;
    } else {
      jsString += `new Uint8Array(instance.exports.${event.name}.buffer)[${
        event.addr + j
      }] = ${byte}\n`;
    }
  });
  return jsString;
}

function callEvent(event: Call) {
  return `instance.exports.${event.name}(${writeParamsString(event.params)})\n`;
}

function tableCallEvent(event: TableCall) {
  return `instance.exports.${event.tableName}.get(${
    event.funcidx
  })(${writeParamsString(event.params)})\n`;
}

function memGrowEvent(event: MemGrow) {
  let jsString = "";
  if (event.import) {
    jsString += `${event.name}.grow(${event.amount})\n`;
  } else {
    jsString += `instance.exports.${event.name}.grow(${event.amount})\n`;
  }
  return jsString;
}

function tableSetEvent(event: TableSet) {
  let jsString = "";
  if (event.import) {
    jsString += `${event.name}.set(${event.idx}, `;
  } else {
    jsString += `instance.exports.${event.name}.set(${event.idx}, `;
  }
  if (event.funcImport) {
    jsString += `${event.funcName}`;
  } else {
    jsString += `instance.exports.${event.funcName}`;
  }
  jsString += `)\n`;
  return jsString;
}

function tableGrowEvent(event: TableGrow) {
  let jsString = "";
  if (event.import) {
    jsString += `${event.name}.grow(${event.amount})\n`;
  } else {
    jsString += `instance.exports.${event.name}.grow(${event.amount})\n`;
  }
  return jsString;
}

function globalSet(event: GlobalSet) {
  let jsString = "";
  if (event.import) {
    jsString += `${event.name}.value = ${event.value}\n`;
  } else {
    jsString += `instance.exports.${event.name}.value = ${
      event.bigInt ? `BigInt(${event.value})` : event.value
    }\n`;
  }
  return jsString;
}

function writeFuncGlobal(funcidx: string) {
  return `global_${funcidx}`;
}

function writeModule(module: string) {
  return `imports['${module}'] = {}`;
}

function writeImport(module: string, name: string) {
  return `imports['${module}']['${name}'] = `;
}

function writeParamsString(params: number[]) {
  let paramsString = "";
  for (let p of params) {
    paramsString += p + ",";
  }
  paramsString = paramsString.slice(0, -1);
  return paramsString;
}
