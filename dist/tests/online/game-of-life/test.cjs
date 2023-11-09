"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const instrumenter_cjs_1 = require("../../../src/instrumenter.cjs");
async function test() {
    const url = 'https://playgameoflife.com/';
    const { browser, page } = await (0, instrumenter_cjs_1.launch)(url);
    // animate user interaction
    return await (0, instrumenter_cjs_1.land)(browser, page);
}
exports.default = test;
//# sourceMappingURL=test.cjs.map