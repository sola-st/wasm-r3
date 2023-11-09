"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.delay = exports.getDirectoryNames = void 0;
const fs = require('fs');
function getDirectoryNames(folderPath) {
    const entries = fs.readdirSync(folderPath, { withFileTypes: true });
    const directories = entries
        .filter((entry) => entry.isDirectory())
        .map((entry) => entry.name);
    return directories;
}
exports.getDirectoryNames = getDirectoryNames;
async function delay(ms) {
    return new Promise(resolve => {
        setTimeout(resolve, ms);
    });
}
exports.delay = delay;
//# sourceMappingURL=test-utils.cjs.map