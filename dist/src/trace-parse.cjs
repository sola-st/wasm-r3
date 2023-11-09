"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function parse(traceString) {
    let trace = [];
    let events = traceString.trim().split('\n');
    for (let event of events) {
        let components = event.split(';');
        switch (components[0]) {
            case 'ImportMemory':
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    pages: parseInt(components[4]),
                });
                break;
            case "ExportCall":
                trace.push({
                    type: components[0],
                    name: components[1],
                    params: splitList(components[2])
                });
                break;
            case "ImportCall":
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    name: components[2]
                });
                break;
            case "ImportReturn":
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    name: components[2],
                    results: splitList(components[3]),
                });
                break;
            case "Load":
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    name: components[2],
                    offset: parseInt(components[3]),
                    data: splitList(components[4]),
                });
                break;
            case "MemGrow":
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    name: components[2],
                    amount: parseInt(components[3])
                });
                break;
            case "TableGet":
                trace.push({
                    type: components[0],
                    tableidx: parseInt(components[1]),
                    name: components[2],
                    idx: parseInt(components[3]),
                    funcidx: parseInt(components[4]),
                    funcName: components[5],
                });
                break;
            case "TableGrow":
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    name: components[2],
                    amount: parseInt(components[3])
                });
                break;
            case 'GlobalGet':
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    name: components[2],
                    value: parseInt(components[3]),
                    valtype: components[4],
                });
                break;
            case 'ImportGlobal':
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    valtype: components[4],
                    value: parseInt(components[5]),
                });
                break;
            case 'ImportFunc':
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                });
                break;
            case 'ImportTable':
                trace.push({
                    type: components[0],
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    initial: parseInt(components[4]),
                    element: components[5]
                });
                break;
            default:
                throw new Error(`${components[0]}: Not a valid trace event`);
        }
    }
    return trace;
}
exports.default = parse;
function splitList(c) {
    let list = c?.split(',').map(parseNumber);
    if (list === undefined || (list.length === 1 && Number.isNaN(list[0]))) {
        return [];
    }
    return list;
}
function parseNumber(n) {
    if (n.includes('.')) {
        return parseFloat(n);
    }
    return parseInt(n);
}
//# sourceMappingURL=trace-parse.cjs.map