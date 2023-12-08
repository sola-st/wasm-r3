import { ReplayToWriteStream } from "./replay-generator.cjs";
import { decode } from "@webassemblyjs/wasm-parser";
import { traverseWithParents, addNode } from "@webassemblyjs/ast";
import { add } from "@webassemblyjs/wasm-edit"
import fs from "fs/promises";

export const generateWasm: ReplayToWriteStream = async (stream, code) => {
    const binary = await fs.readFile('gol/bin_0/index.wasm')
    const ast = decode(binary)
    const newBinary = add(binary, [
        ast.start(0)
    ])
}