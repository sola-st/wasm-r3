mod wasm_parser {
    use anyhow::Result;
    use anyhow::Error;
    use wasmparser::Parser;

    pub(crate) fn reencode(buf: &[u8]) -> Result<()> {
        let parser = Parser::new(0);
        for payload in parser.parse_all(&buf) {
            match payload? {
                wasmparser::Payload::Version { num: num_, encoding: _encoding, range: _range } => {
                    // println!("Version: {}", _num);
                    // println!("Encoding: {:?}", _encoding);
                    // println!("Range: {:?}", _range);
                }
                wasmparser::Payload::TypeSection(_) => {
                    println!("Type section");
                }
                wasmparser::Payload::ImportSection(_) => {
                    println!("Import section");
                }
                wasmparser::Payload::FunctionSection(_) => {
                    println!("Function section");
                }
                wasmparser::Payload::TableSection(_) => {
                    println!("Table section");
                }
                wasmparser::Payload::MemorySection(_) => {
                    println!("Memory section");
                }
                wasmparser::Payload::TagSection(_) => {
                    println!("Tag section");
                }
                wasmparser::Payload::GlobalSection(_) => {
                    println!("Global section");
                }
                wasmparser::Payload::ExportSection(_) => {
                    println!("Export section");
                }
                wasmparser::Payload::StartSection { func, range } => {
                    println!("Start section");
                }
                wasmparser::Payload::ElementSection(_) => {
                    println!("Element section");
                }
                wasmparser::Payload::DataCountSection { count, range } => {
                    println!("Data count section");
                }
                wasmparser::Payload::DataSection(_) => {
                    println!("Data section");
                }
                wasmparser::Payload::CodeSectionStart { count, range, size } => {
                    println!("Code section start");
                }
                wasmparser::Payload::CodeSectionEntry(_) => {
                    println!("Code section entry");
                }
                wasmparser::Payload::ModuleSection { parser, unchecked_range } => {
                    println!("Module section");
                }
                wasmparser::Payload::InstanceSection(_) => {
                    println!("Instance section");
                }
                wasmparser::Payload::CoreTypeSection(_) => {
                    println!("Core type section");
                }
                wasmparser::Payload::ComponentSection { parser, unchecked_range } => {
                    return Err(Error::msg("Component model not supported"));
                }
                wasmparser::Payload::CustomSection(_) => {
                    println!("Custom section");
            
                }
                wasmparser::Payload::UnknownSection { id, contents, range } => {
                    println!("Unknown section");
                }
                wasmparser::Payload::End(_) => {
                    println!("End");
                }
                wasmparser::Payload::ComponentInstanceSection(_) | wasmparser::Payload::ComponentAliasSection(_) | wasmparser::Payload::ComponentTypeSection(_) | wasmparser::Payload::ComponentCanonicalSection(_) => {
                    return Err(Error::msg("Component model not supported"));
                },
                wasmparser::Payload::ComponentStartSection { start: _, range: _ } => {
                    return Err(Error::msg("Component model not supported"));
                }
                wasmparser::Payload::ComponentImportSection(_) => {
                    return Err(Error::msg("Component model not supported"));
                }
                wasmparser::Payload::ComponentExportSection(_) => {
                    return Err(Error::msg("Component model not supported"));
                }
            }
        }
        Ok(())
    }
}