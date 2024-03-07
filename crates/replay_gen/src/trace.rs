//! Trace is just a sequence of WasmEvents.
//! WasmEvent corresponds to a single event that can happen during the execution of a Wasm program.
//! Most usually corresponds to one wasm instruction, e.g. WasmEvent::Load corresponds to one wasm load,
//! but some of them are not. e.g. FuncEntry and FuncReturn correspond to the entry and return of a wasm function.
//! There are also some events that are not part of the execution like Import*, which can be removed later.
use num_traits::FromPrimitive;

use std::fmt::{self};
use std::fmt::{Debug, Display};
use std::fs::File;
use std::io::{BufRead, BufReader, Read};
use std::str::FromStr;
use walrus::{Module, Type};

#[derive(Debug)]
pub enum ErrorKind {
    LegacyTrace,
    UnknownTrace,
    UnknownEventCode(u8),
    TraceEntryIncomplete(String),
    UnknownValTypeCode,
    TypeIdNotInModule(String),
}

#[derive(FromPrimitive, Debug)]
#[num_traits = "some_other_ident"]
pub enum BinCodes {
    LoadI32 = 0x28,
    LoadI64 = 0x29,
    LoadF32 = 0x2A,
    LoadF64 = 0x2B,
    LoadI32_8 = 0x2C,
    LoadI32_16 = 0x2E,
    LoadI64_8 = 0x30,
    LoadI64_16 = 0x32,
    LoadI64_32 = 0x34,
    StoreI32 = 0x36,
    StoreI64 = 0x37,
    StoreF32 = 0x38,
    StoreF64 = 0x39,
    StoreI32_8 = 0x3A,
    StoreI32_16 = 0x3B,
    StoreI64_8 = 0x3C,
    StoreI64_16 = 0x3D,
    StoreI64_32 = 0x3E,
    Call = 0x10,
    CallIndirect = 0x11,
    CallReturn = 0xFF,
    CallIndirectReturn = 0xFE,
    GlobalGet = 0x23,
    GlobalSet = 0x24,
    TableGet = 0x25,
    TableSet = 0x26,
    FuncEntry = 0x02,
    TableEntry = 0x03,
    FuncReturn = 0x0F,
    MemGrow = 0x40,
    // TABLE_GROW = 0x02;
    // IMPORT_CALL = 0x02;
    // IMPORT_RETURN = 0x02;
    // FUNC_ENTRY = 0x02;
    // FUNC_ENTRY_TABLE = 0x02;
    // IMPORT_GLOBAL = 0x02;
}

#[derive(Clone, Debug)]
pub enum LoadValue {
    I8(u8),
    I32(i32),
    I64(i64),
    F32(f32),
    F64(f64),
}

impl Into<Vec<u8>> for LoadValue {
    fn into(self) -> Vec<u8> {
        match self {
            LoadValue::I8(n) => n.to_le_bytes().to_vec(),
            LoadValue::I32(n) => n.to_le_bytes().to_vec(),
            LoadValue::I64(n) => n.to_le_bytes().to_vec(),
            LoadValue::F32(n) => n.to_le_bytes().to_vec(),
            LoadValue::F64(n) => n.to_le_bytes().to_vec(),
        }
    }
}

impl Into<Vec<F64>> for LoadValue {
    fn into(self) -> Vec<F64> {
        match self {
            LoadValue::I8(n) => n.to_le_bytes().map(|b| F64(b as f64)).to_vec(),
            LoadValue::I32(n) => n.to_le_bytes().map(|b| F64(b as f64)).to_vec(),
            LoadValue::I64(n) => n.to_le_bytes().map(|b| F64(b as f64)).to_vec(),
            LoadValue::F32(n) => n.to_le_bytes().map(|b| F64(b as f64)).to_vec(),
            LoadValue::F64(n) => n.to_le_bytes().map(|b| F64(b as f64)).to_vec(),
        }
    }
}

#[derive(Clone, Debug)]
pub enum StoreValue {
    I8(i8),
    I16(i16),
    I32(i32),
    I64(i64),
    F32(f32),
    F64(f64),
}

impl Into<Vec<u8>> for StoreValue {
    fn into(self) -> Vec<u8> {
        match self {
            StoreValue::I8(n) => n.to_le_bytes().to_vec(),
            StoreValue::I16(n) => n.to_le_bytes().to_vec(),
            StoreValue::I32(n) => n.to_le_bytes().to_vec(),
            StoreValue::I64(n) => n.to_le_bytes().to_vec(),
            StoreValue::F32(n) => n.to_le_bytes().to_vec(),
            StoreValue::F64(n) => n.to_le_bytes().to_vec(),
        }
    }
}

impl Display for LoadValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            LoadValue::I8(n) => write!(f, "{}", n),
            LoadValue::I32(n) => write!(f, "{}", n),
            LoadValue::I64(n) => write!(f, "{}", n),
            LoadValue::F32(n) => write!(f, "{}", n),
            LoadValue::F64(n) => write!(f, "{}", n),
        }
    }
}

impl Display for StoreValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            StoreValue::I8(n) => write!(f, "{}", n),
            StoreValue::I16(n) => write!(f, "{}", n),
            StoreValue::I32(n) => write!(f, "{}", n),
            StoreValue::I64(n) => write!(f, "{}", n),
            StoreValue::F32(n) => write!(f, "{}", n),
            StoreValue::F64(n) => write!(f, "{}", n),
        }
    }
}

#[derive(Clone, Debug)]
pub enum WasmEvent {
    // Each corresponds to a single wasm instruction.
    Load { idx: usize, offset: i32, data: LoadValue },
    Store { idx: usize, offset: i32, data: StoreValue },
    MemGrow { idx: usize, amount: i32 },
    TableGet { tableidx: usize, idx: usize, funcidx: i32 },
    TableSet { tableidx: usize, idx: usize, funcidx: i32 },
    TableGrow { idx: usize, amount: i32 },
    GlobalGet { idx: usize, value: F64, valtype: ValType },
    GlobalSet { idx: usize, value: F64, valtype: ValType },
    Call { idx: usize },
    CallIndirect { tableidx: usize, idx: usize, funcidx: i32 },
    CallReturn { idx: usize, results: Vec<F64> },
    // These do not correspond to a wasm instruction, but used to track control flow
    FuncEntry { idx: usize, params: Vec<F64> },
    FuncEntryTable { idx: usize, tableidx: usize, params: Vec<F64> },
    FuncReturn,
}

type ModuleTypes = Vec<Type>;
impl WasmEvent {
    pub fn decode_string(reader: &mut BufReader<File>) -> Result<Vec<Self>, ErrorKind> {
        let mut event = String::new();
        match reader.read_line(&mut event) {
            Ok(_) => {
                if event != "" {
                    let event = event.trim();
                    Ok(vec![event.parse()?])
                } else {
                    Ok(Vec::new())
                }
            }
            Err(_) => Ok(Vec::new()),
        }
    }

    pub fn decode_bin(reader: &mut BufReader<File>, module: &Module, lookup: &Vec<i32>) -> Result<Vec<WasmEvent>, ErrorKind> {
        match read_u8(reader) {
            Ok(code) => {
                let code = BinCodes::from_u8(code).ok_or(ErrorKind::UnknownEventCode(code))?;
                // dbg!(&code);
                let module_types = get_module_type(module);
                let events = match code {
                    BinCodes::LoadI32 => WasmEvent::decode_load(reader, LoadValue::I32(0)),
                    BinCodes::LoadI64 => WasmEvent::decode_load(reader, LoadValue::I64(0)),
                    BinCodes::LoadF32 => WasmEvent::decode_load(reader, LoadValue::F32(0.0)),
                    BinCodes::LoadF64 => WasmEvent::decode_load(reader, LoadValue::F64(0.0)),
                    BinCodes::LoadI32_8 => WasmEvent::decode_load(reader, LoadValue::I32(0)),
                    BinCodes::LoadI32_16 => WasmEvent::decode_load(reader, LoadValue::I32(0)),
                    BinCodes::LoadI64_8 => WasmEvent::decode_load(reader, LoadValue::I64(0)),
                    BinCodes::LoadI64_16 => WasmEvent::decode_load(reader, LoadValue::I64(0)),
                    BinCodes::LoadI64_32 => WasmEvent::decode_load(reader, LoadValue::I64(0)),
                    BinCodes::StoreI32 => WasmEvent::decode_store(reader, StoreValue::I32(0), &ValType::I32),
                    BinCodes::StoreI64 => WasmEvent::decode_store(reader, StoreValue::I64(0), &ValType::I64),
                    BinCodes::StoreF32 => WasmEvent::decode_store(reader, StoreValue::F32(0.0), &ValType::F32),
                    BinCodes::StoreF64 => WasmEvent::decode_store(reader, StoreValue::F64(0.0), &ValType::F64),
                    BinCodes::StoreI32_8 => WasmEvent::decode_store(reader, StoreValue::I8(0), &ValType::I32),
                    BinCodes::StoreI32_16 => WasmEvent::decode_store(reader, StoreValue::I16(0), &ValType::I32),
                    BinCodes::StoreI64_8 => WasmEvent::decode_store(reader, StoreValue::I8(0), &ValType::I64),
                    BinCodes::StoreI64_16 => WasmEvent::decode_store(reader, StoreValue::I16(0), &ValType::I64),
                    BinCodes::StoreI64_32 => WasmEvent::decode_store(reader, StoreValue::I32(0), &ValType::I64),
                    BinCodes::Call => WasmEvent::decode_call(reader),
                    BinCodes::CallIndirect => WasmEvent::decode_call_indirect(reader, lookup),
                    BinCodes::CallIndirectReturn => WasmEvent::decode_indirect_call_return(reader, module_types, lookup),
                    BinCodes::GlobalGet => WasmEvent::decode_global_get(reader),
                    BinCodes::GlobalSet => WasmEvent::decode_global_set(reader),
                    BinCodes::TableGet => WasmEvent::decode_table_get(reader, lookup),
                    BinCodes::TableSet => WasmEvent::decode_table_set(reader),
                    BinCodes::FuncReturn => WasmEvent::decode_func_return(reader),
                    BinCodes::CallReturn => WasmEvent::decode_call_return(reader, module_types),
                    BinCodes::FuncEntry => WasmEvent::decode_func_entry(reader, module_types),
                    BinCodes::TableEntry => WasmEvent::decode_table_entry(reader, module_types),
                    BinCodes::MemGrow => WasmEvent::decode_mem_grow(reader),
                }?;
                Ok(events)
            }
            Err(_e) => Ok(Vec::new()),
        }
    }

    fn decode_mem_grow(reader: &mut BufReader<File>) -> Result<Vec<Self>, ErrorKind> {
        let amount =
            read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode amount for memory.grow")))?;
        Ok(vec![WasmEvent::MemGrow { idx: 0, amount }])
    }

    fn decode_func_return(_reader: &mut BufReader<File>) -> Result<Vec<Self>, ErrorKind> {
        Ok(vec![WasmEvent::FuncReturn])
    }

    fn decode_global_get(reader: &mut BufReader<File>) -> Result<Vec<Self>, ErrorKind> {
        let valtype = WasmEvent::decode_val_type(reader)?;
        let idx = WasmEvent::decode_value(reader, &ValType::I32)?;
        let value = WasmEvent::decode_value(reader, &valtype)?;
        Ok(vec![WasmEvent::GlobalGet { idx: idx.0 as usize, value, valtype }])
    }

    fn decode_global_set(reader: &mut BufReader<File>) -> Result<Vec<Self>, ErrorKind> {
        let valtype = WasmEvent::decode_val_type(reader)?;
        let value = WasmEvent::decode_value(reader, &valtype)?;
        let idx = WasmEvent::decode_value(reader, &ValType::I32)?;
        Ok(vec![WasmEvent::GlobalSet { idx: idx.0 as usize, value, valtype }])
    }

    fn decode_table_set(reader: &mut BufReader<File>) -> Result<Vec<Self>, ErrorKind> {
        let idx = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode table idx for table.set")))?
            as usize;
        let funcidx =
            read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode funcidx for table.set")))?;
        Ok(vec![WasmEvent::TableSet { tableidx: 0, idx, funcidx }])
    }

    fn decode_table_get(reader: &mut BufReader<File>, lookup: &Vec<i32>) -> Result<Vec<Self>, ErrorKind> {
        let tableidx = read_i32(reader)
            .map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode tableidx for table.get")))?
            as usize;
        let idx =
            read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode idx for table.get")))? as usize;
        let lookupidx =
            read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode funcidx for table.get")))? as usize;
        let funcidx = *lookup.get(lookupidx).unwrap();
        Ok(vec![WasmEvent::TableGet { tableidx, idx, funcidx }])
    }

    fn decode_call_indirect(reader: &mut BufReader<File>, lookup: &Vec<i32>) -> Result<Vec<Self>, ErrorKind> {
        let tableidx = read_i32(reader)
            .map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode tableidx for table.get")))?
            as usize;
        let idx = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode table idx for table.get")))?
            as usize;
        let lookupidx =
            read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode funcidx for table.get")))? as usize;
        let funcidx = *lookup.get(lookupidx).unwrap();
        Ok(vec![
            WasmEvent::TableGet { tableidx, idx, funcidx },
            WasmEvent::CallIndirect { tableidx, idx, funcidx },
        ])
    }

    fn decode_indirect_call_return(
        reader: &mut BufReader<File>,
        module_types: ModuleTypes,
        lookup: &Vec<i32>,
    ) -> Result<Vec<Self>, ErrorKind> {
        let lookupidx =
            read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode funcidx for table.get")))? as usize;
        let idx = *lookup.get(lookupidx).unwrap() as usize;
        let type_id = read_i32(reader)
            .map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode type idx of call return")))?
            as usize;
        let typ = module_types
            .get(type_id)
            .ok_or(ErrorKind::TypeIdNotInModule(format!("for decode call return: {}", type_id)))?;
        let results = typ
            .results()
            .into_iter()
            .map(|p| match p {
                walrus::ValType::I32 => F64(read_i32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::I64 => F64(read_i64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F32 => F64(read_f32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F64 => F64(read_f64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::V128 => todo!(),
                walrus::ValType::Externref => todo!(),
                walrus::ValType::Funcref => todo!(),
            })
            .collect();
        Ok(vec![WasmEvent::CallReturn { idx, results }])
    }

    fn decode_func_entry(reader: &mut BufReader<File>, module_types: ModuleTypes) -> Result<Vec<Self>, ErrorKind> {
        let idx = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode func idx for func entry")))?
            as usize;
        let type_id = read_i32(reader)
            .map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode type idx for func entry")))?
            as usize;
        let typ = module_types
            .get(type_id)
            .ok_or(ErrorKind::TypeIdNotInModule(format!("for decode func entry: {}", type_id)))?;
        let params = typ
            .params()
            .into_iter()
            .map(|p| match p {
                walrus::ValType::I32 => F64(read_i32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::I64 => F64(read_i64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F32 => F64(read_f32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F64 => F64(read_f64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::V128 => todo!(),
                walrus::ValType::Externref => todo!(),
                walrus::ValType::Funcref => todo!(),
            })
            .collect();
        let ret = vec![WasmEvent::FuncEntry { idx, params }];
        Ok(ret)
    }

    fn decode_table_entry(reader: &mut BufReader<File>, module_types: ModuleTypes) -> Result<Vec<Self>, ErrorKind> {
        let idx = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode func idx for func entry")))?
            as usize;
        let type_id = read_i32(reader)
            .map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode type idx for func entry")))?
            as usize;
        let typ = module_types
            .get(type_id)
            .ok_or(ErrorKind::TypeIdNotInModule(format!("for decode func entry: {}", type_id)))?;
        let params = typ
            .params()
            .into_iter()
            .map(|p| match p {
                walrus::ValType::I32 => F64(read_i32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::I64 => F64(read_i64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F32 => F64(read_f32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F64 => F64(read_f64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::V128 => todo!(),
                walrus::ValType::Externref => todo!(),
                walrus::ValType::Funcref => todo!(),
            })
            .collect();
        let ret = vec![WasmEvent::FuncEntryTable { idx, tableidx: 0, params }];
        Ok(ret)
    }

    fn decode_call_return(reader: &mut BufReader<File>, module_types: ModuleTypes) -> Result<Vec<Self>, ErrorKind> {
        let idx = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode func idx of call return")))?
            as usize;
        let type_id = read_i32(reader)
            .map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode type idx of call return")))?
            as usize;
        let typ = module_types
            .get(type_id)
            .ok_or(ErrorKind::TypeIdNotInModule(format!("for decode call return: {}", type_id)))?;
        let results = typ
            .results()
            .into_iter()
            .map(|p| match p {
                walrus::ValType::I32 => F64(read_i32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::I64 => F64(read_i64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F32 => F64(read_f32(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::F64 => F64(read_f64(reader).map_err(|_| ErrorKind::UnknownTrace).unwrap() as f64),
                walrus::ValType::V128 => todo!(),
                walrus::ValType::Externref => todo!(),
                walrus::ValType::Funcref => todo!(),
            })
            .collect();
        Ok(vec![WasmEvent::CallReturn { idx, results }])
    }

    fn decode_call(reader: &mut BufReader<File>) -> Result<Vec<Self>, ErrorKind> {
        let idx =
            read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode func idx for call")))? as usize;
        Ok(vec![WasmEvent::Call { idx }])
    }

    fn decode_load(reader: &mut BufReader<File>, mut data: LoadValue) -> Result<Vec<Self>, ErrorKind> {
        let offset = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode load offset")))?;
        Self::decode_load_value(reader, &mut data)?;
        Ok(vec![WasmEvent::Load { idx: 0, offset, data }])
    }

    fn decode_store(reader: &mut BufReader<File>, mut _data: StoreValue, valtype: &ValType) -> Result<Vec<Self>, ErrorKind> {
        // let value = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?;
        // Self::decode_store_value(reader, &mut data)?;
        // let data = StoreValue::I32(value);
        let data = match valtype {
            ValType::I32 => StoreValue::I32(
                read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?,
            ),
            ValType::I64 => StoreValue::I64(
                read_i64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?,
            ),
            ValType::F32 => StoreValue::F32(
                read_f32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?,
            ),
            ValType::F64 => StoreValue::F64(
                read_f64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?,
            ),
            ValType::V128 => todo!(),
            ValType::Anyref => todo!(),
            ValType::Externref => todo!(),
        };
        let offset = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store offset")))?;
        let e = WasmEvent::Store { idx: 0, offset, data };
        Ok(vec![e])
    }

    fn decode_store_value(reader: &mut BufReader<File>, data: &mut StoreValue) -> Result<(), ErrorKind> {
        match data {
            StoreValue::I8(v) => {
                *v = read_i8(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?
            }
            StoreValue::I16(v) => {
                *v = read_i16(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?
            }
            StoreValue::I32(v) => {
                *v = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?
            }
            StoreValue::I64(v) => {
                *v = read_i64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?
            }
            StoreValue::F32(v) => {
                *v = read_f32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?
            }
            StoreValue::F64(v) => {
                *v = read_f64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode store value")))?
            }
        };
        Ok(())
    }

    fn decode_load_value(reader: &mut BufReader<File>, data: &mut LoadValue) -> Result<(), ErrorKind> {
        match data {
            LoadValue::I8(v) => {
                *v = read_u8(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode load value")))?
            }
            LoadValue::I32(v) => {
                *v = read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode load value")))?
            }
            LoadValue::I64(v) => {
                *v = read_i64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode load value")))?
            }
            LoadValue::F32(v) => {
                *v = read_f32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode load value")))?
            }
            LoadValue::F64(v) => {
                *v = read_f64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode load value")))?
            }
        };
        Ok(())
    }

    fn decode_value(reader: &mut BufReader<File>, valtype: &ValType) -> Result<F64, ErrorKind> {
        let value = match valtype {
            ValType::I32 => {
                F64(read_i32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode value")))? as f64)
            }
            ValType::I64 => {
                F64(read_i64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode value")))? as f64)
            }
            ValType::F32 => {
                F64(read_f32(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode value")))? as f64)
            }
            ValType::F64 => {
                F64(read_f64(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode value")))? as f64)
            }
            _ => todo!("These ValTypes not supported yet"),
        };
        Ok(value)
    }

    fn decode_val_type(reader: &mut BufReader<File>) -> Result<ValType, ErrorKind> {
        let code = read_u8(reader).map_err(|_| ErrorKind::TraceEntryIncomplete(String::from("decode valtype code")))?;
        match code {
            0 => Ok(ValType::I32),
            1 => Ok(ValType::I64),
            2 => Ok(ValType::F32),
            3 => Ok(ValType::F64),
            _ => Err(ErrorKind::UnknownValTypeCode),
        }
    }
}

// TODO: this is a hack to get around the fact that the trace generated by js. Remove when we discard js based trace.
#[derive(Copy, Clone, PartialEq)]
pub struct F64(pub f64);

impl fmt::Display for F64 {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if self.0.is_infinite() {
            write!(f, "Infinity")
        } else if self.0.is_nan() {
            write!(f, "NaN")
        } else {
            write!(f, "{}", self.0)
        }
    }
}
// TODO: make this more elegant
// This is currently done for outputting to WAT.
impl fmt::Debug for F64 {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if self.0.is_infinite() {
            write!(f, "0x7FF0000000000000")
        } else if self.0.is_nan() {
            write!(f, "nan")
        } else {
            write!(f, "{}", self.0)
        }
    }
}

impl std::str::FromStr for F64 {
    type Err = std::num::ParseFloatError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "Infinity" => Ok(Self(std::f64::INFINITY)),
            _ => s.parse::<f64>().map(Self),
        }
    }
}

#[derive(Clone, PartialEq)]
pub enum ValType {
    I32,
    I64,
    F32,
    F64,
    V128,
    Anyref,
    Externref,
}

impl Display for ValType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::I32 => write!(f, "i32"),
            Self::I64 => write!(f, "i64"),
            Self::F32 => write!(f, "f32"),
            Self::F64 => write!(f, "f64"),
            Self::V128 => write!(f, "v128"),
            Self::Anyref => write!(f, "anyfunc"),
            Self::Externref => write!(f, "externref"),
        }
    }
}

impl Debug for ValType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::I32 => write!(f, "i32"),
            Self::I64 => write!(f, "i64"),
            Self::F32 => write!(f, "f32"),
            Self::F64 => write!(f, "f64"),
            Self::V128 => write!(f, "v128"),
            Self::Anyref => write!(f, "funcref"),
            Self::Externref => write!(f, "externref"),
        }
    }
}

impl std::str::FromStr for ValType {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "i32" => Ok(Self::I32),
            "i64" => Ok(Self::I64),
            "f32" => Ok(Self::F32),
            "f64" => Ok(Self::F64),
            "v128" => Ok(Self::V128),
            "anyref" => Ok(Self::Anyref),
            "externref" => Ok(Self::Externref),
            _ => Err(()),
        }
    }
}

impl From<walrus::ValType> for ValType {
    fn from(val: walrus::ValType) -> Self {
        match val {
            walrus::ValType::I32 => Self::I32,
            walrus::ValType::I64 => Self::I64,
            walrus::ValType::F32 => Self::F32,
            walrus::ValType::F64 => Self::F64,
            walrus::ValType::V128 => Self::V128,
            walrus::ValType::Externref => Self::Externref,
            walrus::ValType::Funcref => Self::Anyref,
        }
    }
}

fn join_vec(args: &Vec<F64>) -> String {
    args.iter().map(|x| x.to_string()).collect::<Vec<String>>().join(",")
}

fn parse_number(s: &str) -> Option<F64> {
    let s = s.trim(); // Remove leading/trailing whitespace

    match s {
        "" | "+" | "-" => None, // Handle empty or only sign character
        "Infinity" | "+Infinity" => Some(F64(std::f64::INFINITY)),
        "-Infinity" => Some(F64(std::f64::NEG_INFINITY)),
        _ => {
            if let Ok(num) = s.parse::<f64>() {
                Some(F64(num)) // Handle floats and scientific notation
            } else {
                None // Not a number
            }
        }
    }
}

#[test]
fn test_parse_number() {
    // problematic case reading the trace generateed by js
    let s = "0.7614822387695312";
    assert_ne!(s, parse_number(s).unwrap().to_string());
}

impl FromStr for WasmEvent {
    type Err = ErrorKind;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        fn split_list(c: &str) -> Vec<F64> {
            let list = c.split(',').filter_map(|s| parse_number(s)).collect::<Vec<_>>();
            if list.is_empty() || (list.len() == 1 && list[0].0.is_nan()) {
                vec![]
            } else {
                list
            }
        }

        let components: Vec<&str> = s.split(';').collect();
        match components[0] {
            "EC" => Ok(WasmEvent::FuncEntry {
                idx: components[1].parse().unwrap(),
                params: split_list(components.get(3).unwrap()),
            }),
            "TC" => Ok(WasmEvent::FuncEntryTable {
                idx: components[1].parse().unwrap(),
                tableidx: components[3].parse().unwrap(),
                params: split_list(components.get(4).unwrap()),
            }),
            "ER" => Ok(WasmEvent::FuncReturn),
            "IC" => Ok(WasmEvent::Call { idx: components[1].parse().unwrap() }),
            "IR" => Ok(WasmEvent::CallReturn {
                idx: components[1].parse().unwrap(),
                results: split_list(components.get(3).unwrap()),
            }),
            "L" => Ok(WasmEvent::Load {
                idx: components[1].parse().unwrap(),
                offset: components[3].parse().unwrap(),
                data: LoadValue::I8(components[4].parse().unwrap()),
            }),
            "MG" => Ok(WasmEvent::MemGrow {
                idx: components[1].parse().unwrap(),
                amount: components[3].parse().unwrap(),
            }),
            "T" => Ok(WasmEvent::TableGet {
                tableidx: components[1].parse().unwrap(),
                idx: components[3].parse().unwrap(),
                funcidx: components[4].parse().unwrap(),
            }),
            "TG" => Ok(WasmEvent::TableGrow {
                idx: components[1].parse().unwrap(),
                amount: components[3].parse().unwrap(),
            }),
            "G" => Ok(WasmEvent::GlobalGet {
                idx: components[1].parse().unwrap(),
                value: parse_number(components[3]).unwrap(),
                valtype: components[4].parse().unwrap(),
            }),
            "IT" | "IM" | "IF" | "IG" => Err(ErrorKind::LegacyTrace),
            _ => {
                panic!("Unknown trace: {:?}", s);
                Err(ErrorKind::UnknownTrace)
            }
        }
    }
}

impl Display for WasmEvent {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            WasmEvent::Load { idx, offset, data } => {
                write!(f, "Load idx={} offset={} data={}\n", idx, offset, data)
            }
            WasmEvent::Store { idx, offset, data } => write!(f, "Store idx={} offset={} data={}\n", idx, offset, data),
            WasmEvent::MemGrow { idx, amount } => {
                write!(f, "MG;{};{}\n", idx, amount)
            }
            WasmEvent::TableGet { tableidx, idx, funcidx } => {
                write!(f, "table.get idx={} offset={} funcidx={}\n", tableidx, idx, funcidx)
            }
            WasmEvent::TableGrow { idx, amount } => {
                write!(f, "MG;{};{}\n", idx, amount)
            }
            WasmEvent::GlobalGet { idx, value, valtype } => {
                write!(f, "global.get idx={} value={} valtype={:?}\n", idx, value, valtype)
            }
            WasmEvent::FuncEntry { params, idx } => {
                write!(f, "FuncEntry idx={} params={}\n", idx, join_vec(params))
            }
            WasmEvent::FuncEntryTable { idx, tableidx: funcidx, params } => {
                write!(
                    f,
                    "FuncEntryThroughTable idx={} funcidx={} parmams={}\n",
                    idx,
                    funcidx,
                    join_vec(params),
                )
            }
            WasmEvent::FuncReturn => write!(f, "FuncExit\n"),
            WasmEvent::Call { idx } => write!(f, "Call funcidx={}\n", idx),
            WasmEvent::CallReturn { idx, results } => {
                write!(f, "CallReturn funcidx={} results={}\n", idx, join_vec(results))
            }
            WasmEvent::CallIndirect { tableidx, idx, funcidx } => {
                write!(f, "CallIndirect tableidx={} offset={} funcidx={}\n", tableidx, idx, funcidx)
            }
            _ => {
                /* Ignore rest for now*/
                Ok(())
            }
        }
    }
}

fn read_u8(reader: &mut BufReader<File>) -> anyhow::Result<u8> {
    let mut buf = [0; 1];
    reader.read_exact(&mut buf)?;
    Ok(buf[0])
}

fn read_i8(reader: &mut BufReader<File>) -> anyhow::Result<i8> {
    let mut buf = [0; 1];
    reader.read_exact(&mut buf)?;
    Ok(buf[0] as i8)
}

fn read_i16(reader: &mut BufReader<File>) -> anyhow::Result<i16> {
    let mut buf = [0; 2];
    reader.read_exact(&mut buf)?;
    Ok(i16::from_le_bytes(buf))
}

fn read_i32(reader: &mut BufReader<File>) -> anyhow::Result<i32> {
    let mut buf = [0; 4];
    reader.read_exact(&mut buf)?;
    Ok(i32::from_le_bytes(buf))
}

fn read_i64(reader: &mut BufReader<File>) -> anyhow::Result<i64> {
    let mut buf = [0; 8];
    reader.read_exact(&mut buf)?;
    Ok(i64::from_le_bytes(buf))
}

fn read_f32(reader: &mut BufReader<File>) -> anyhow::Result<f32> {
    let mut buf = [0; 4];
    reader.read_exact(&mut buf)?;
    Ok(f32::from_le_bytes(buf))
}

fn read_f64(reader: &mut BufReader<File>) -> anyhow::Result<f64> {
    let mut buf = [0; 8];
    reader.read_exact(&mut buf)?;
    Ok(f64::from_le_bytes(buf))
}

fn get_module_type(module: &Module) -> ModuleTypes {
    module.types.iter().map(|t| t.clone()).collect()
}
