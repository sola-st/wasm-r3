# Summary on Wasabi's structure
- Wasabi is composed of two components
	- `wasabi_wasm` : parsing and encoding WASM binaries into `wasabi_wasm`-defined AST
	- `wasabi` : instrumenting instructions in AST format
- To extend `wasabi_wasm` with new WASM feature, we should
	- Define new AST for new instruction
	- Parsing from the new instruction to the new AST
	- Encoding from the new AST to the new instruction
- To extend `wasabi` to instrument new WASM instruction, we should
	- Define a instrumentation for the instruction
---
# Current status on extending Wasabi
## Goal
- We want to use Wasabi to instrument WASM binaries and record traces
- Wasabi is based on WASM 1.0, so it need to be extended to support WASM 2.0 features
	- [WASM 2.0 Changelog](https://webassembly.github.io/spec/core/appendix/changes.html#release-2-0)
	- Most importantly, we need to add support to instrument **table instructions** such as `table.get` or `table.set`
- [ ] Required decision making
	- What range of new features should we support for Wasabi?
		- For tracing purpose itself, we only need to add support for table instructions
		- To successfully parse WASM 2.0 binaries, we need to support parsing & encoding all new instructions in WASM 2.0. This includes vector (SIMD) instructions, function & external reference types, bulk memory & table instructions which will be cumbersome to fully implement, but unrelated for our tracing purpose.
		- Refer to [WASM 2.0 Change History](https://webassembly.github.io/spec/core/appendix/changes.html#release-2-0) for full list of new features 
## Extending Wasabi for Table Instructions
### Table instructions: new WASM 2.0 instructions
- `table.get x` : consume a `i32` from stack as an index, returns the table element in the index.
- `table.set x` : consume a `i32` as an index and a `t`value, puts the value in the table's index-th entry, and returns nothing.
- `table.size x` : consume nothing, returns a `i32` representing the size of the table.
- `table.grow x` : consume 
- Table instruction argument `x` : decides the index of table that the instruction should operate on (WASM 2.0 supports multiple tables per module).
### Extending `wasabi_wasm` with table instructions
**Defining new ASTs for table instructions**
```rust
pub enum Instr {
	...
	TableGet(Idx<Table>),
	TableSet(Idx<Table>),
	TableSize(Idx<Table>),
	TableGrow(Idx<Table>),
}
```
- Defined new AST for 4 instructions in `Instr` enum.
**Parsing table instructions**
```rust
fn parse_instr(...) {
	...
	Ok(match op {
		...
		wp::TableGet { table: x } => TableGet(x.into()),
		wp::TableSet { table: x } => TableSet(x.into()),
        wp::TableGrow { table: x } => TableGrow(x.into()),
        wp::TableSize { table: x } => TableSize(x.into()),
	})
}
```
- Depends on `wasmparser` library
	- `wp` : namespace of operators(instructions) defined by `wasmparser`
	- `parse_instr` matches the parsing result of the operator and produces corresponding AST (defined in `wasabi_wasm`).
**Encoding table instructions**
```rust
fn encode_instruction(...) {
	Ok(match *hl_instr {
		...
		Instr::TableGet(x) => we::Instruction::TableGet(x.to_u32()),
        Instr::TableSet(x) => we::Instruction::TableSet(x.to_u32()),
        Instr::TableSize(x) => we::Instruction::TableSize(x.to_u32()),
        Instr::TableGrow(x) => we::Instruction::TableGrow(x.to_u32()),

	})
}
```
- Depends on `wasm_encoder` library
	- `we` : namespace of WASM instructions defined by `wasm_encoder`
	- `encode_instruction` matches the AST and produces corresponding encoding define in `wasm_encoder`.
**Defining instrumentation for table instructions**
- [ ] TODO - Technical challenge : we should define an instrumentation for each table instruction(i.e. what instructions should be added around each table instruction), which does not change original behavior and connects the low-level hook. We can refer to Wasabi paper and see how other similar instructions (ex. `load`, `store` instructions) are instrumented.