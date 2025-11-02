#!/bin/bash
set -e

git submodule update --init --recursive
cargo install wasm-pack --version 0.13.1 --locked
npm install
npm run build
npx playwright install-deps
npx playwright install

pip install tabulate ipykernel scipy matplotlib
