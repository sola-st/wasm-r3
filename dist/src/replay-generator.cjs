"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const util_cjs_1 = require("./util.cjs");
class Generator {
    code;
    state;
    constructor() {
        this.code = new Code();
        this.state = { callStack: [] };
    }
    generateReplay(trace) {
        trace.forEach((event) => {
            switch (event.type) {
                case "ExportCall":
                    if (this.state.callStack.length === 0) {
                        this.code.calls.push({ name: event.name, params: event.params });
                        break;
                    }
                    this.pushEvent({ type: 'Call', name: event.name });
                    break;
                case "ImportCall":
                    this.code.funcImports[event.idx].body.push({ results: [], events: [] });
                    this.state.callStack.push(this.code.funcImports[event.idx]);
                    break;
                case "ImportReturn":
                    this.state.lastFunc = this.state.callStack.pop();
                    this.state.lastFunc.body.slice(-1)[0].results = event.results;
                    break;
                case "Load":
                    this.pushEvent({
                        type: 'Store',
                        import: this.code.memImports[event.idx] !== undefined,
                        name: event.name,
                        addr: event.offset,
                        data: event.data,
                    });
                    break;
                case 'MemGrow':
                    this.pushEvent({
                        type: event.type,
                        import: this.code.memImports[event.idx] !== undefined,
                        name: event.name,
                        amount: event.amount
                    });
                    break;
                case "TableGet":
                    this.pushEvent({
                        type: 'TableSet',
                        import: this.code.tableImports[event.tableidx] !== undefined,
                        name: event.name,
                        idx: event.idx,
                        funcImport: this.code.funcImports[event.funcidx] !== undefined,
                        funcName: event.funcName
                    });
                    break;
                case "TableGrow":
                    this.pushEvent({
                        type: event.type,
                        import: this.code.tableImports[event.idx] !== undefined,
                        name: event.name,
                        idx: event.idx,
                        amount: event.amount
                    });
                    break;
                case 'ImportMemory':
                    this.addModule(event);
                    this.code.memImports[event.idx] = {
                        module: event.module,
                        name: event.name,
                        pages: event.pages
                    };
                    break;
                case 'GlobalGet':
                    this.pushEvent({
                        type: 'GlobalSet',
                        import: this.code.globalImports[event.idx] !== undefined,
                        name: event.name,
                        value: event.value,
                        bigInt: event.valtype === 'i64'
                    });
                    break;
                case 'ImportTable':
                    this.addModule(event);
                    this.code.tableImports[event.idx] = {
                        module: event.module,
                        name: event.name,
                        element: event.element,
                        initial: event.initial,
                        maximum: event.maximum,
                    };
                    break;
                case 'ImportGlobal':
                    this.addModule(event);
                    this.code.globalImports[event.idx] = {
                        module: event.module,
                        name: event.name,
                        valtype: event.valtype,
                        value: event.value,
                    };
                    break;
                case 'ImportFunc':
                    this.addModule(event);
                    this.code.funcImports[event.idx] = {
                        module: event.module,
                        name: event.name,
                        body: []
                    };
                    break;
                default:
                    (0, util_cjs_1.unreachable)(event);
            }
        });
        return this.code;
    }
    pushEvent(event) {
        const stackTop = this.state.callStack.slice(-1)[0]?.body.slice(-1)[0];
        if (stackTop === undefined) {
            if (this.state.lastFunc === undefined) {
                this.code.initialization.push(event);
                return;
            }
            this.state.lastFunc.body.slice(-1)[0].events.push(event);
            return;
        }
        if (stackTop.events?.slice(-1)[0]?.type === "Call") {
            stackTop.events.splice(stackTop.events.length - 1, 0, event);
            return;
        }
        stackTop.events.push(event);
    }
    addModule(event) {
        if (!this.code.modules.includes(event.module)) {
            this.code.modules.push(event.module);
        }
    }
}
exports.default = Generator;
class Code {
    funcImports;
    memImports;
    tableImports;
    globalImports;
    calls;
    initialization;
    modules;
    constructor() {
        this.funcImports = {};
        this.memImports = {};
        this.tableImports = {};
        this.globalImports = {};
        this.calls = [];
        this.initialization = [];
        this.modules = [];
    }
    toString() {
        let jsString = `import fs from 'fs'\n`;
        jsString += `import path from 'path'\n`;
        jsString += `const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n`;
        jsString += `const wasmBinary = fs.readFileSync(p)\n`;
        jsString += `let instance\n`;
        jsString += 'let imports = {}\n';
        // Init modules
        for (let module of this.modules) {
            jsString += `imports.${module} = {}\n`;
        }
        // Init memories
        for (let memidx in this.memImports) {
            let mem = this.memImports[memidx];
            jsString += `const ${mem.name} = new WebAssembly.Memory({ initial: ${mem.pages}, maximum: ${mem.pages /*This is wrong. You need to traxe the actual maximum here*/} })\n`;
            jsString += `imports.${mem.module}.${mem.name} = ${mem.name}\n`;
        }
        // Init globals
        for (let globalIdx in this.globalImports) {
            let global = this.globalImports[globalIdx];
            jsString += `const ${global.name} = new WebAssembly.Global({ value: '${global.valtype}', mutable: true}, ${global.value})\n`;
            jsString += `${global.name}.value = ${global.value}\n`;
            jsString += `imports.${global.module}.${global.name} = ${global.name}\n`;
        }
        // Init tables
        for (let tableidx in this.tableImports) {
            let table = this.tableImports[tableidx];
            jsString += `const ${table.name} = new WebAssembly.Table({ initial: ${table.initial}, element: '${table.element}'})\n`;
            jsString += `imports.${table.module}.${table.name} = ${table.name}\n`;
        }
        // Init entity states
        for (let event of this.initialization) {
            switch (event.type) {
                case 'Store':
                    jsString += this.storeEvent(event);
                    break;
                case 'MemGrow':
                    jsString += this.memGrowEvent(event);
                    break;
                case 'TableSet':
                    jsString += this.tableSetEvent(event);
                    break;
                case 'TableGrow':
                    jsString += this.tableGrowEvent(event);
                    break;
            }
        }
        // Imported functions
        for (let funcidx in this.funcImports) {
            jsString += `let ${global(funcidx)} = -1\n`;
            let func = this.funcImports[funcidx];
            jsString += `imports.${func.module}.${func.name} = `;
            jsString += `() => {\n`;
            jsString += `${global(funcidx)}++\n`;
            jsString += `switch (${global(funcidx)}) {\n`;
            func.body.forEach((b, i) => {
                jsString += `case ${i}:\n`;
                for (let event of b.events) {
                    switch (event.type) {
                        case 'Call':
                            jsString += `instance.exports.${event.name}()\n`;
                            break;
                        case 'Store':
                            jsString += this.storeEvent(event);
                            break;
                        case 'MemGrow':
                            jsString += this.memGrowEvent(event);
                            break;
                        case 'TableSet':
                            jsString += this.tableSetEvent(event);
                            break;
                        case 'TableGrow':
                            jsString += this.tableGrowEvent(event);
                            break;
                        case 'GlobalSet':
                            jsString += this.globalSet(event);
                            break;
                        default: (0, util_cjs_1.unreachable)(event);
                    }
                }
                jsString += `return ${b.results[0]} \n`;
            });
            jsString += '}\n';
            jsString += '}\n';
        }
        jsString += `let wasm = await WebAssembly.instantiate(wasmBinary, imports) \n`;
        jsString += `instance = wasm.instance\n`;
        for (let exp of this.calls) {
            let paramsString = '';
            for (let p of exp.params) {
                paramsString += p + ',';
            }
            paramsString = paramsString.slice(0, -1);
            jsString += `await instance.exports.${exp.name}(${paramsString}) \n`;
        }
        return jsString;
    }
    storeEvent(event) {
        let jsString = '';
        event.data.forEach((byte, j) => {
            event = event;
            if (event.import) {
                jsString += `new Uint8Array(${event.name}.buffer)[${event.addr + j}] = ${byte}\n`;
            }
            else {
                jsString += `new Uint8Array(instance.exports.${event.name}.buffer)[${event.addr + j}] = ${byte}\n`;
            }
        });
        return jsString;
    }
    memGrowEvent(event) {
        let jsString = '';
        if (event.import) {
            jsString += `${event.name}.grow(${event.amount})\n`;
        }
        else {
            jsString += `instance.exports.${event.name}.grow(${event.amount})\n`;
        }
        return jsString;
    }
    tableSetEvent(event) {
        let jsString = '';
        if (event.import) {
            jsString += `${event.name}.set(${event.idx}, `;
        }
        else {
            jsString += `instance.exports.${event.name}.set(${event.idx}, `;
        }
        if (event.funcImport) {
            jsString += `${event.funcName}`;
        }
        else {
            jsString += `instance.exports.${event.funcName}`;
        }
        jsString += `)\n`;
        return jsString;
    }
    tableGrowEvent(event) {
        let jsString = '';
        if (event.import) {
            jsString += `${event.name}.grow(${event.amount})\n`;
        }
        else {
            jsString += `instance.exports.${event.name}.grow(${event.amount})\n`;
        }
        return jsString;
    }
    globalSet(event) {
        let jsString = '';
        if (event.import) {
            jsString += `${event.name}.value = ${event.value}\n`;
        }
        else {
            jsString += `instance.exports.${event.name}.value = ${event.bigInt ? `BigInt(${event.value})` : event.value}\n`;
        }
        return jsString;
    }
}
function global(funcidx) {
    return `global_${funcidx} `;
}
//# sourceMappingURL=replay-generator.cjs.map