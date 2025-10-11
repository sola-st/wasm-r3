#!/bin/bash
set -e

git submodule update --init --recursive
cargo install wasm-pack
npm install
npm run build
npx playwright install-deps
npx playwright install

pip install tabulate ipykernel scipy matplotlib
