/*
* Generated by Wasabi. DO NOT EDIT.
* Contains:
*   - independent of program-to-instrument: long.js dependency, Wasabi loader and runtime
*   - generated from program-to-instrument: static information and low-level hooks
*/

// long.js
!function(t,i){"object"==typeof exports&&"object"==typeof module?module.exports=i():"function"==typeof define&&define.amd?define([],i):"object"==typeof exports?exports.Long=i():t.Long=i()}("undefined"!=typeof self?self:this,function(){return function(t){function i(e){if(n[e])return n[e].exports;var r=n[e]={i:e,l:!1,exports:{}};return t[e].call(r.exports,r,r.exports,i),r.l=!0,r.exports}var n={};return i.m=t,i.c=n,i.d=function(t,n,e){i.o(t,n)||Object.defineProperty(t,n,{configurable:!1,enumerable:!0,get:e})},i.n=function(t){var n=t&&t.__esModule?function(){return t.default}:function(){return t};return i.d(n,"a",n),n},i.o=function(t,i){return Object.prototype.hasOwnProperty.call(t,i)},i.p="",i(i.s=0)}([function(t,i){function n(t,i,n){this.low=0|t,this.high=0|i,this.unsigned=!!n}function e(t){return!0===(t&&t.__isLong__)}function r(t,i){var n,e,r;return i?(t>>>=0,(r=0<=t&&t<256)&&(e=l[t])?e:(n=h(t,(0|t)<0?-1:0,!0),r&&(l[t]=n),n)):(t|=0,(r=-128<=t&&t<128)&&(e=f[t])?e:(n=h(t,t<0?-1:0,!1),r&&(f[t]=n),n))}function s(t,i){if(isNaN(t))return i?p:m;if(i){if(t<0)return p;if(t>=c)return q}else{if(t<=-v)return _;if(t+1>=v)return E}return t<0?s(-t,i).neg():h(t%d|0,t/d|0,i)}function h(t,i,e){return new n(t,i,e)}function u(t,i,n){if(0===t.length)throw Error("empty string");if("NaN"===t||"Infinity"===t||"+Infinity"===t||"-Infinity"===t)return m;if("number"==typeof i?(n=i,i=!1):i=!!i,(n=n||10)<2||36<n)throw RangeError("radix");var e;if((e=t.indexOf("-"))>0)throw Error("interior hyphen");if(0===e)return u(t.substring(1),i,n).neg();for(var r=s(a(n,8)),h=m,o=0;o<t.length;o+=8){var g=Math.min(8,t.length-o),f=parseInt(t.substring(o,o+g),n);if(g<8){var l=s(a(n,g));h=h.mul(l).add(s(f))}else h=h.mul(r),h=h.add(s(f))}return h.unsigned=i,h}function o(t,i){return"number"==typeof t?s(t,i):"string"==typeof t?u(t,i):h(t.low,t.high,"boolean"==typeof i?i:t.unsigned)}t.exports=n;var g=null;try{g=new WebAssembly.Instance(new WebAssembly.Module(new Uint8Array([0,97,115,109,1,0,0,0,1,13,2,96,0,1,127,96,4,127,127,127,127,1,127,3,7,6,0,1,1,1,1,1,6,6,1,127,1,65,0,11,7,50,6,3,109,117,108,0,1,5,100,105,118,95,115,0,2,5,100,105,118,95,117,0,3,5,114,101,109,95,115,0,4,5,114,101,109,95,117,0,5,8,103,101,116,95,104,105,103,104,0,0,10,191,1,6,4,0,35,0,11,36,1,1,126,32,0,173,32,1,173,66,32,134,132,32,2,173,32,3,173,66,32,134,132,126,34,4,66,32,135,167,36,0,32,4,167,11,36,1,1,126,32,0,173,32,1,173,66,32,134,132,32,2,173,32,3,173,66,32,134,132,127,34,4,66,32,135,167,36,0,32,4,167,11,36,1,1,126,32,0,173,32,1,173,66,32,134,132,32,2,173,32,3,173,66,32,134,132,128,34,4,66,32,135,167,36,0,32,4,167,11,36,1,1,126,32,0,173,32,1,173,66,32,134,132,32,2,173,32,3,173,66,32,134,132,129,34,4,66,32,135,167,36,0,32,4,167,11,36,1,1,126,32,0,173,32,1,173,66,32,134,132,32,2,173,32,3,173,66,32,134,132,130,34,4,66,32,135,167,36,0,32,4,167,11])),{}).exports}catch(t){}n.prototype.__isLong__,Object.defineProperty(n.prototype,"__isLong__",{value:!0}),n.isLong=e;var f={},l={};n.fromInt=r,n.fromNumber=s,n.fromBits=h;var a=Math.pow;n.fromString=u,n.fromValue=o;var d=4294967296,c=d*d,v=c/2,w=r(1<<24),m=r(0);n.ZERO=m;var p=r(0,!0);n.UZERO=p;var y=r(1);n.ONE=y;var b=r(1,!0);n.UONE=b;var N=r(-1);n.NEG_ONE=N;var E=h(-1,2147483647,!1);n.MAX_VALUE=E;var q=h(-1,-1,!0);n.MAX_UNSIGNED_VALUE=q;var _=h(0,-2147483648,!1);n.MIN_VALUE=_;var B=n.prototype;B.toInt=function(){return this.unsigned?this.low>>>0:this.low},B.toNumber=function(){return this.unsigned?(this.high>>>0)*d+(this.low>>>0):this.high*d+(this.low>>>0)},B.toString=function(t){if((t=t||10)<2||36<t)throw RangeError("radix");if(this.isZero())return"0";if(this.isNegative()){if(this.eq(_)){var i=s(t),n=this.div(i),e=n.mul(i).sub(this);return n.toString(t)+e.toInt().toString(t)}return"-"+this.neg().toString(t)}for(var r=s(a(t,6),this.unsigned),h=this,u="";;){var o=h.div(r),g=h.sub(o.mul(r)).toInt()>>>0,f=g.toString(t);if(h=o,h.isZero())return f+u;for(;f.length<6;)f="0"+f;u=""+f+u}},B.getHighBits=function(){return this.high},B.getHighBitsUnsigned=function(){return this.high>>>0},B.getLowBits=function(){return this.low},B.getLowBitsUnsigned=function(){return this.low>>>0},B.getNumBitsAbs=function(){if(this.isNegative())return this.eq(_)?64:this.neg().getNumBitsAbs();for(var t=0!=this.high?this.high:this.low,i=31;i>0&&0==(t&1<<i);i--);return 0!=this.high?i+33:i+1},B.isZero=function(){return 0===this.high&&0===this.low},B.eqz=B.isZero,B.isNegative=function(){return!this.unsigned&&this.high<0},B.isPositive=function(){return this.unsigned||this.high>=0},B.isOdd=function(){return 1==(1&this.low)},B.isEven=function(){return 0==(1&this.low)},B.equals=function(t){return e(t)||(t=o(t)),(this.unsigned===t.unsigned||this.high>>>31!=1||t.high>>>31!=1)&&(this.high===t.high&&this.low===t.low)},B.eq=B.equals,B.notEquals=function(t){return!this.eq(t)},B.neq=B.notEquals,B.ne=B.notEquals,B.lessThan=function(t){return this.comp(t)<0},B.lt=B.lessThan,B.lessThanOrEqual=function(t){return this.comp(t)<=0},B.lte=B.lessThanOrEqual,B.le=B.lessThanOrEqual,B.greaterThan=function(t){return this.comp(t)>0},B.gt=B.greaterThan,B.greaterThanOrEqual=function(t){return this.comp(t)>=0},B.gte=B.greaterThanOrEqual,B.ge=B.greaterThanOrEqual,B.compare=function(t){if(e(t)||(t=o(t)),this.eq(t))return 0;var i=this.isNegative(),n=t.isNegative();return i&&!n?-1:!i&&n?1:this.unsigned?t.high>>>0>this.high>>>0||t.high===this.high&&t.low>>>0>this.low>>>0?-1:1:this.sub(t).isNegative()?-1:1},B.comp=B.compare,B.negate=function(){return!this.unsigned&&this.eq(_)?_:this.not().add(y)},B.neg=B.negate,B.add=function(t){e(t)||(t=o(t));var i=this.high>>>16,n=65535&this.high,r=this.low>>>16,s=65535&this.low,u=t.high>>>16,g=65535&t.high,f=t.low>>>16,l=65535&t.low,a=0,d=0,c=0,v=0;return v+=s+l,c+=v>>>16,v&=65535,c+=r+f,d+=c>>>16,c&=65535,d+=n+g,a+=d>>>16,d&=65535,a+=i+u,a&=65535,h(c<<16|v,a<<16|d,this.unsigned)},B.subtract=function(t){return e(t)||(t=o(t)),this.add(t.neg())},B.sub=B.subtract,B.multiply=function(t){if(this.isZero())return m;if(e(t)||(t=o(t)),g){return h(g.mul(this.low,this.high,t.low,t.high),g.get_high(),this.unsigned)}if(t.isZero())return m;if(this.eq(_))return t.isOdd()?_:m;if(t.eq(_))return this.isOdd()?_:m;if(this.isNegative())return t.isNegative()?this.neg().mul(t.neg()):this.neg().mul(t).neg();if(t.isNegative())return this.mul(t.neg()).neg();if(this.lt(w)&&t.lt(w))return s(this.toNumber()*t.toNumber(),this.unsigned);var i=this.high>>>16,n=65535&this.high,r=this.low>>>16,u=65535&this.low,f=t.high>>>16,l=65535&t.high,a=t.low>>>16,d=65535&t.low,c=0,v=0,p=0,y=0;return y+=u*d,p+=y>>>16,y&=65535,p+=r*d,v+=p>>>16,p&=65535,p+=u*a,v+=p>>>16,p&=65535,v+=n*d,c+=v>>>16,v&=65535,v+=r*a,c+=v>>>16,v&=65535,v+=u*l,c+=v>>>16,v&=65535,c+=i*d+n*a+r*l+u*f,c&=65535,h(p<<16|y,c<<16|v,this.unsigned)},B.mul=B.multiply,B.divide=function(t){if(e(t)||(t=o(t)),t.isZero())throw Error("division by zero");if(g){if(!this.unsigned&&-2147483648===this.high&&-1===t.low&&-1===t.high)return this;return h((this.unsigned?g.div_u:g.div_s)(this.low,this.high,t.low,t.high),g.get_high(),this.unsigned)}if(this.isZero())return this.unsigned?p:m;var i,n,r;if(this.unsigned){if(t.unsigned||(t=t.toUnsigned()),t.gt(this))return p;if(t.gt(this.shru(1)))return b;r=p}else{if(this.eq(_)){if(t.eq(y)||t.eq(N))return _;if(t.eq(_))return y;return i=this.shr(1).div(t).shl(1),i.eq(m)?t.isNegative()?y:N:(n=this.sub(t.mul(i)),r=i.add(n.div(t)))}if(t.eq(_))return this.unsigned?p:m;if(this.isNegative())return t.isNegative()?this.neg().div(t.neg()):this.neg().div(t).neg();if(t.isNegative())return this.div(t.neg()).neg();r=m}for(n=this;n.gte(t);){i=Math.max(1,Math.floor(n.toNumber()/t.toNumber()));for(var u=Math.ceil(Math.log(i)/Math.LN2),f=u<=48?1:a(2,u-48),l=s(i),d=l.mul(t);d.isNegative()||d.gt(n);)i-=f,l=s(i,this.unsigned),d=l.mul(t);l.isZero()&&(l=y),r=r.add(l),n=n.sub(d)}return r},B.div=B.divide,B.modulo=function(t){if(e(t)||(t=o(t)),g){return h((this.unsigned?g.rem_u:g.rem_s)(this.low,this.high,t.low,t.high),g.get_high(),this.unsigned)}return this.sub(this.div(t).mul(t))},B.mod=B.modulo,B.rem=B.modulo,B.not=function(){return h(~this.low,~this.high,this.unsigned)},B.and=function(t){return e(t)||(t=o(t)),h(this.low&t.low,this.high&t.high,this.unsigned)},B.or=function(t){return e(t)||(t=o(t)),h(this.low|t.low,this.high|t.high,this.unsigned)},B.xor=function(t){return e(t)||(t=o(t)),h(this.low^t.low,this.high^t.high,this.unsigned)},B.shiftLeft=function(t){return e(t)&&(t=t.toInt()),0==(t&=63)?this:t<32?h(this.low<<t,this.high<<t|this.low>>>32-t,this.unsigned):h(0,this.low<<t-32,this.unsigned)},B.shl=B.shiftLeft,B.shiftRight=function(t){return e(t)&&(t=t.toInt()),0==(t&=63)?this:t<32?h(this.low>>>t|this.high<<32-t,this.high>>t,this.unsigned):h(this.high>>t-32,this.high>=0?0:-1,this.unsigned)},B.shr=B.shiftRight,B.shiftRightUnsigned=function(t){if(e(t)&&(t=t.toInt()),0===(t&=63))return this;var i=this.high;if(t<32){return h(this.low>>>t|i<<32-t,i>>>t,this.unsigned)}return 32===t?h(i,0,this.unsigned):h(i>>>t-32,0,this.unsigned)},B.shru=B.shiftRightUnsigned,B.shr_u=B.shiftRightUnsigned,B.toSigned=function(){return this.unsigned?h(this.low,this.high,!1):this},B.toUnsigned=function(){return this.unsigned?this:h(this.low,this.high,!0)},B.toBytes=function(t){return t?this.toBytesLE():this.toBytesBE()},B.toBytesLE=function(){var t=this.high,i=this.low;return[255&i,i>>>8&255,i>>>16&255,i>>>24,255&t,t>>>8&255,t>>>16&255,t>>>24]},B.toBytesBE=function(){var t=this.high,i=this.low;return[t>>>24,t>>>16&255,t>>>8&255,255&t,i>>>24,i>>>16&255,i>>>8&255,255&i]},n.fromBytes=function(t,i,e){return e?n.fromBytesLE(t,i):n.fromBytesBE(t,i)},n.fromBytesLE=function(t,i){return new n(t[0]|t[1]<<8|t[2]<<16|t[3]<<24,t[4]|t[5]<<8|t[6]<<16|t[7]<<24,i)},n.fromBytesBE=function(t,i){return new n(t[4]<<24|t[5]<<16|t[6]<<8|t[7],t[0]<<24|t[1]<<16|t[2]<<8|t[3],i)}}])});

/*
 * Wasabi loader (monkey-patches WebAssembly.instantiate()) and runtime (e.g., for resolving call_indirect).
 */

let Wasabi = {
    HOOK_NAMES: [
        "start",
        "if_",
        "br",
        "br_if",
        "br_table",
        "begin",
        "end",
        "nop",
        "unreachable",
        "drop",
        "select",
        "call_pre",
        "call_post",
        "return_",
        "const_",
        "unary",
        "binary",
        "load",
        "store",
        "memory_size",
        "memory_grow",
        "local",
        "global"
    ],

    // map a table index to a function index
    resolveTableIdx: function (tableIdx) {
        if (Wasabi.module.exports === undefined || Wasabi.module.table === undefined) {
            return undefined;
        }

        const resolvedFunction = Wasabi.module.table.get(tableIdx);
        if (resolvedFunction === null) {
            return undefined;
        }

        // NOTE We want to get the _index_ of the resolved function to the analysis code, but the
        // WebAssembly API only gives us a _function object_.
        // HACK We can abuse the `.name` property of the function object to get the index.
        // See the MDN, which says the "name property is the toString() result of the function's 
        // index in the wasm module".
        // https://developer.mozilla.org/en-US/docs/WebAssembly/Exported_functions
        const resolvedFunctionIdx = parseInt(resolvedFunction.name);

        // However, because we inserted a bunch of imported hook functions into the module, the
        // index retrieved above is in terms of the _instrumented_ module. We want to get the
        // function index in the _original_ module however, so we adjust it here:
        if (resolvedFunctionIdx >= Wasabi.module.info.originalFunctionImportsCount) {
            return resolvedFunctionIdx - Object.keys(Wasabi.module.lowlevelHooks).length;
        } else {
            return resolvedFunctionIdx;
        }
    },

    // call end hooks for all "intermediate" or "implicitly ended blocks" of a branch table
    endBrTableBlocks: function(brTablesInfoIdx, brTableIdx, func) {
        const table = Wasabi.module.info.brTables[brTablesInfoIdx].table;
        const default_ = Wasabi.module.info.brTables[brTablesInfoIdx].default;
        const target = (table[brTableIdx] === undefined) ? default_ : table[brTableIdx];

        // NOTE this is a JavaScript impl of the Wasabi to_end_hook_args() function in Rust
        for (const block of target.ends) {
            const [type, begin, end, begin_if] = block;
            Wasabi.analysis.end(
                {func, instr: end},
                type,
                {func, instr: begin},
                // not undefined only for block type "else"
                (begin_if === undefined) ? undefined : {func, instr: begin_if});
        }
    },

    module: {
        // filled at instrumentation time
        // TODO flatten info into module itself, by using Object.assign in generated code
        info: undefined, lowlevelHooks: undefined,
        // filled after instantiation
        exports: undefined, table: undefined,
    },

    // filled by user or with empty hooks (as fallback) before instantiation
    analysis: {}
};

// monkey-patch WebAssembly.instantiate() and .instantiateStreaming() to add Wasabi
{
    // NOTE even though nothing is done with their arguments, we should provide them because it speeds up in Firefox
    // maybe because this way the JIT can inline the functions???
    const defaultHooks = {
        start(location) {},
        nop(location) {},
        unreachable(location) {},
        if_(location, condition) {},
        br(location, target) {},
        br_if(location, conditionalTarget, condition) {},
        br_table(location, table, defaultTarget, tableIdx) {},
        begin(location, type) {},
        end(location, type, beginLocation, ifLocation) {},
        drop(location, value) {},
        select(location, cond, first, second) {},
        call_pre(location, targetFunc, args, indirectTableIdx) {},
        call_post(location, values) {},
        return_(location, values) {},
        const_(location, op, value) {},
        unary(location, op, input, result) {},
        binary(location, op, first, second, result) {},
        load(location, op, memarg, value) {},
        store(location, op, memarg, value) {},
        memory_size(location, currentSizePages) {},
        memory_grow(location, byPages, previousSizePages) {},
        local(location, op, localIndex, value) {},
        global(location, op, globalIndex, value) {},
    }

    const assertInstantiationPrecondition = function() {
        if (Wasabi.module.info === undefined || Wasabi.module.lowlevelHooks === undefined) {
            throw "missing static info or low-level hooks, did you include the Wasabi-generated JavaScript file?";
        }
    }

    const importObjectWithHooks = function(importObject) {
        for (const hook of Wasabi.HOOK_NAMES) {
            if (Wasabi.analysis[hook] === undefined) {
                Wasabi.analysis[hook] = defaultHooks[hook];
            }
        }
        let importObjectWithHooks = importObject || {};
        importObjectWithHooks.__wasabi_hooks = Wasabi.module.lowlevelHooks;
        return importObjectWithHooks;
    }

    const wireInstanceExports = function(instance) {
        Wasabi.module.exports = instance.exports;
        Wasabi.module.table = instance.exports[Wasabi.module.info.tableExportName];
    }

    const oldInstantiate = WebAssembly.instantiate;
    WebAssembly.instantiate = (sourceBuffer, importObject) => {
        assertInstantiationPrecondition();
        const result = oldInstantiate(sourceBuffer, importObjectWithHooks(importObject));
        // as soon as instance is available, save exports and table
        result.then(({module, instance}) => {
            wireInstanceExports(instance);
        });

        // FIXME Due to the added imports of __wasabi functions, host code that mutates the table
        // might insert the wrong numerical index into the table.
        // We could at least detect (and warn that this changes behavior), or fix it, by wrapping
        // the exported table in a proxy object, that adapts the inserted get/set calls accordingly.

        return result;
    };

    // just fall-back to regular instantiation since Wasabi doesn't support streaming instrumentation (yet) anyway
    const oldInstantiateStreaming = WebAssembly.instantiateStreaming;
    WebAssembly.instantiateStreaming = async (source, importObject) => {
        let response = await source;
        let buffer = await response.arrayBuffer();
        return WebAssembly.instantiate(buffer, importObject);
    };

    const oldInstance = WebAssembly.Instance;
    const newInstance = function(module, importObject) {
        assertInstantiationPrecondition();
        const instance = new oldInstance(module, importObjectWithHooks(importObject));
        wireInstanceExports(instance);
        return instance;
    };
    WebAssembly.Instance = newInstance;
}

Wasabi.module.info = {"functions":[{"type":"|","import":["env","changeMem"],"export":[],"locals":"","instrCount":0},{"type":"|","import":null,"export":["main"],"locals":"","instrCount":5}],"globals":"","start":null,"tableExportName":null,"brTables":[],"originalFunctionImportsCount":1};

Wasabi.module.lowlevelHooks = {
"begin_function": function (func, instr, ) {
    Wasabi.analysis.begin({func, instr}, "function");
},
"call": function (func, instr, targetFunc) {
    Wasabi.analysis.call_pre({func, instr}, targetFunc, []);
},
"call_post": function (func, instr, ) {
    Wasabi.analysis.call_post({func, instr}, []);
},
"i32_load": function (func, instr, offset, align, addr, value) {
    Wasabi.analysis.load({func, instr}, "i32.load", {addr, offset, align}, value);
},
};

let trace = []
let shadowMemory = []
let actualMemory
// TODO: let shadowTables = []

let init = true
Wasabi.analysis = {

    begin(location, type) {
        if (init) {
            actualMemory = Wasabi.module.exports.memory.buffer
            shadowMemory = cloneDeep(actualMemory)
            // TODO: shadowTables init
            init = false
        }
        if (type === "function") {
            trace.push({ type: "ExportCall", names: Wasabi.module.info.functions[location.func].export, params: [] })
        }
    },

    store(location, op, memarg, value) {
        let addr = memarg.addr
        let data
        switch (op) {
            case 'i32.store':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break;
            case 'i32.store8':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 1)
                break;
            case 'i32.store16':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 2)
                break;
            case 'i64.store':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break;
            case 'i64.store8':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 1)
                break;
            case 'i64.store16':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 2)
                break;
            case 'i64.store32':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 4)
                break;
            case 'f32.store':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break;
            case 'f64.store':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break;
            default:
                throw `instruction ${op} not supported`
            // TODO: support for remaining store instructions
        }
    },

    // TODO: bulk memory instructions

    memory_grow(location, byPages, previousSizePages) {
        shadowMemory.grow(byPages)
    },

    load(location, op, memarg, value) {
        let addr = memarg.addr
        let shadow
        let data
        switch (op) {
            case 'i32.load':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'i32.load8_s':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i32.load8_u':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i32.load16_s':
                if (mem_content_equals(addr, 2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i32.load16_u':
                if (mem_content_equals(2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i64.load':
                if (mem_content_equals(addr, 8)) {
                    return
                }
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break
            case 'i64.load8_s':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i64.load8_u':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i64.load16_s':
                if (mem_content_equals(addr, 2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i64.load16_u':
                if (mem_content_equals(addr, 2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i64.load32_s':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'i64.load32_u':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'f32.load':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'f64.load':
                if (mem_content_equals(addr, 8)) {
                    return
                }
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break
            default:
                throw `instruction ${op} not supported`
            // TODO: Support all loads
        }

        trace.push({ type: "Load", memidx: 1, offset: addr, data })
    },

    // TODO: table_set
    // TODO: table_grow
    // TODO: table_get


    call_pre(location, targetFunc, args, indirectTableIdx) {
        let module = Wasabi.module.info.functions[targetFunc].import[0]
        let name = Wasabi.module.info.functions[targetFunc].import[1]
        trace.push({ type: "ImportCall", funcidx: targetFunc, module, name, params: args })
    },

    call_post(location, values) {
        let funcidx
        for (let i = trace.length - 1; i >= 0; i--) {
            if (trace[i].type === 'ImportCall') {
                funcidx = trace[i].funcidx
            }
        }
        if (funcidx === undefined) {
            throw 'this cannot be, there must be a call before a return event'
        }
        let importReturn = {
            type: "ImportReturn",
            funcidx,
            results: values,
            memGrow: [],
            tableGrow: [],
        }
        if (Wasabi.module.exports.memory.buffer.byteLength > shadowMemory.byteLength) {
            // TODO: grow memory
        }
        // TODO: check if table needs to be grown and grow it
        trace.push(importReturn)
    },
}

function set_shadow_memory(data, address, numBytes) {
    for (let i = 0; i < numBytes; i++) {
        let shadowArray = new Uint8Array(shadowMemory)
        shadowArray[address + i] = data[i]
    }
}

function mem_content_equals(addr, numBytes) {
    for (let i = 0; i < numBytes; i++) {
        if (new Uint8Array(shadowMemory)[addr + i] !== new Uint8Array(actualMemory)[addr + i]) {
            return false
        }
    }
    return true
}

/**
 * Get the contents of the actual memory
 * @param {*} addr offset
 * @param {*} numBits how many Bits to read
 * @returns Memory is organized in little endian, so is the return value
 */
function get_actual_mem(addr, numBytes) {
    let uint1Array = new Uint8Array(numBytes)
    for (let i = 0; i < numBytes; i++) {
        uint1Array[i] = new Uint8Array(actualMemory)[addr + i]
    }
    return uint1Array
}

function cloneDeep(obj) {
    if (obj === null || typeof obj !== 'object') {
        return obj;
    }

    if (Array.isArray(obj)) {
        const arrCopy = [];
        for (let i = 0; i < obj.length; i++) {
            arrCopy[i] = cloneDeep(obj[i]);
        }
        return arrCopy;
    }

    const objCopy = {};
    for (const key in obj) {
        if (obj.hasOwnProperty(key)) {
            objCopy[key] = cloneDeep(obj[key]);
        }
    }
    return objCopy;
}

function stringifyTrace(trace) {
    function str(list) {
        let s = ""
        for (let l of list) {
            s += l + ","
        }
        return s.slice(0, -1)
    }
    let traceString = ""
    for (let t of trace) {
        switch (t.type) {
            case "Load":
                traceString += "Load;" + t.memidx + ";" + t.offset + ";" + str(t.data)
                break
            case "TableGet":
                traceString += "TableGet;" + t.tableidx + ";" + t.idx + ";" + t.ref
                break
            case "ExportCall":
                traceString += "ExportCall;" + str(t.names)
                break
            case "ImportCall":
                traceString += "ImportCall;" + t.funcidx + ';' + t.module + ";" + t.name + ";" + str(t.params)
                break
            case "ImportReturn":
                traceString += "ImportReturn;" + t.funcidx + ';' + str(t.results) + ";" + str(t.memGrow) + ";" + str(t.tableGrow)
                break
            default:
                throw "Invalid Trace event type"
        }
        traceString += "\n"
    }
    return traceString
}

export default async () => {
    const fs = await import('fs')
    const path = await import('path')

    let instance
    let imports = {
        env: {
            changeMem: () => (
                new Uint8Array(instance.exports.memory.buffer)[1] = 1
            )
        }
    }
    let wasmBinary = fs.readFileSync(path.join(import.meta.dir, './index.wasm'))
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
    return trace
}
