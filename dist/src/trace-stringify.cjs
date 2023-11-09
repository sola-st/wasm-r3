"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const util_cjs_1 = require("./util.cjs");
function stringifyTrace(trace) {
    let traceString = "";
    for (let e of trace) {
        switch (e.type) {
            case "Load":
                traceString += stringifyEvent(e.type, e.idx, e.name, e.offset, str(e.data));
                break;
            case 'MemGrow':
            case 'TableGrow':
                traceString += stringifyEvent(e.type, e.idx, e.name, e.amount);
                break;
            case "TableGet":
                traceString += stringifyEvent(e.type, e.tableidx, e.name, e.idx, e.funcidx, e.funcName);
                break;
            case 'GlobalGet':
                traceString += stringifyEvent(e.type, e.idx, e.name, e.value, e.valtype);
                break;
            case "ExportCall":
                traceString += stringifyEvent(e.type, e.name, str(e.params));
                break;
            case "ImportCall":
                traceString += stringifyEvent(e.type, e.idx, e.name);
                break;
            case "ImportReturn":
                traceString += stringifyEvent(e.type, e.idx, e.name, str(e.results));
                break;
            case 'ImportMemory':
                traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.pages);
                break;
            case 'ImportGlobal':
                traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.valtype, e.value);
                break;
            case 'ImportFunc':
                traceString += stringifyEvent(e.type, e.idx, e.module, e.name);
                break;
            case 'ImportTable':
                traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.initial, e.element);
                break;
            default:
                (0, util_cjs_1.unreachable)(e);
        }
        traceString += "\n";
    }
    return traceString;
}
exports.default = stringifyTrace;
function stringifyEvent(...fields) {
    let eventString = '';
    for (let field of fields) {
        eventString += field + ';';
    }
    return eventString.slice(0, -1);
}
function str(list) {
    let s = "";
    for (let l of list) {
        s += l + ",";
    }
    return s.slice(0, -1);
}
//# sourceMappingURL=trace-stringify.cjs.map