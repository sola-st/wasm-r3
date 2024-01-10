//! Trace is just a sequence of WasmEvents.
//! WasmEvent corresponds to a single event that can happen during the execution of a Wasm program.
//! Most usually corresponds to one wasm instruction, e.g. WasmEvent::Load corresponds to one wasm load,
//! but some of them are not. e.g. FuncEntry and FuncReturn correspond to the entry and return of a wasm function.
//! There are also some events that are not part of the execution like Import*, which can be removed later.
use futures::{stream, Stream, StreamExt};
use num_traits::{FromPrimitive, ToBytes};

use std::borrow::BorrowMut;
use std::fmt::{self};
use std::fmt::{Debug, Display};
use std::path::Path;
use std::pin::Pin;
use std::str::FromStr;
use std::sync::Arc;
use std::task::{Context, Poll};
use tokio::fs::File;
use tokio::io::{self, AsyncBufReadExt, AsyncReadExt, AsyncWriteExt, BufReader, BufWriter};
use walrus::{DataKind, Module};

#[derive(Debug)]
pub enum ErrorKind {
    LegacyTrace,
    UnknownTrace,
}

#[derive(FromPrimitive)]
#[num_traits = "some_other_ident"]
enum BinCodes {
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
    GlobalGet = 0x23,
    GlobalSet = 0x24,
    TableGet = 0x25,
    TableSet = 0x26,
    FuncReturn = 0x0F,
    // MEM_GROW = 0x02;
    // TABLE_GROW = 0x02;
    // IMPORT_CALL = 0x02;
    // IMPORT_RETURN = 0x02;
    // FUNC_ENTRY = 0x02;
    // FUNC_ENTRY_TABLE = 0x02;
    // IMPORT_GLOBAL = 0x02;
}

enum MemValue {
    U8,
    I8,
    U16,
    I16,
    U32,
    I32,
    I64,
    F32,
    F64,
}

#[derive(Clone)]
enum StoreValue {
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

pub struct ShadowMemory(Vec<u8>);

impl ShadowMemory {
    fn new(module: &Module) -> Self {
        if module.memories.len() > 1 {
            todo!("Multiple memories not supported yet");
        }
        let mut memory = ShadowMemory(vec![
            0u8;
            module.memories.iter().find(|m| true).map(|m| m.initial).unwrap() as usize
        ]);
        module.data.iter().for_each(|d| {
            if let DataKind::Active(data) = d.kind {
                let offset = match data.location {
                    walrus::ActiveDataLocation::Absolute(n) => n as usize,
                    walrus::ActiveDataLocation::Relative(_) => todo!("Relative data segment offset not supported yet"),
                };
                memory.store(offset, d.value);
            }
        });
        memory
    }

    fn store(&mut self, offset: usize, data: impl Into<Vec<u8>>) {
        let data = data.into();
        self.0[offset..data.len()].copy_from_slice(&data);
    }
}

pub struct Trace(Vec<WasmEvent>);

impl Trace {

    pub fn from_text_file(path: Path) -> Trace {
        let reader = BufReader::new(file);
        Trace(reader.lines().map(|e| e.parse()).collect())
    }

    pub fn from_binary(file: File, module: Module) -> Trace {
        let mut reader = io::BufReader::new(file);
        todo!()
        // Trace::new(
        //         let event = WasmEvent::decode(&mut reader).await.unwrap();
        //         Some((event, reader))
        //     })),
        //     module,
        // )
    }

    // pub fn pipe<F>(&mut self, f: dyn FnMut() -> WasmEvent) {
    //     f(self.trace);
    // }

    pub async fn opt_shadow_mem(&mut self) {
        // self.trace;
        // let _ = self.trace.filter_map(|e| async {
        //     match e {
        //         WasmEvent::Load { idx, offset, data } => todo!(),
        //         WasmEvent::Store { offset, data } => {

        //             // shadow_mem.store(offset as usize, data);
        //             None
        //         }
        //         _ => Some(e),
        //     }
        // });
    }

    pub fn opt_shadow_table(&mut self, module: &Module) {}

    pub fn opt_shadow_global(&mut self, module: &Module) {}

    pub fn opt_function_entry(&mut self) {}

    pub async fn to_text(self, file: &mut File) -> Result<(), std::io::Error> {
        let mut writer = BufWriter::new(file);
        let stream = self.trace;
        let mut stream = stream.map(|e| format!("{}", e));
        while let Some(e) = stream.next().await {
            writer.write_all(e.as_bytes()).await?;
        }
        writer.flush().await?;
        Ok(())
    }
}

impl Stream for Trace {
    type Item = WasmEvent;

    fn poll_next(mut self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Option<Self::Item>> {
        self.trace.poll_next_unpin(cx)
    }
}

struct TraceOptimiser {
    module: Module,
    shadow_mem: ShadowMemory,
}

impl TraceOptimiser {
    async fn opt_shadow_mem(&self, trace: &mut Trace, module: &Module) {
        let mut shadow_mem: ShadowMemory = ShadowMemory::new(module);
        let mut filter = false;
        while let Some(e) = trace.next().await {
            match e.clone() {
                WasmEvent::Load { idx, offset, data } => filter = true,
                WasmEvent::Store { offset, data } => shadow_mem.store(offset as usize, data.clone()),
                _ => {}
            }
        }
        let _ = trace.filter_map(|e| async {
            match e {
                WasmEvent::Load { idx, offset, data } => {
                    if filter == true {
                        None
                    } else {
                        Some(e)
                    }
                }
                WasmEvent::Store { offset, data } => None,
                _ => Some(e),
            }
        });
        // let _ = trace.filter_map(|e| async {
        //     match e {
        //         WasmEvent::Load { idx, offset, data } => todo!(),
        //         WasmEvent::Store { offset, data } => {
        //             shadow_mem.store(offset as usize, data);
        //             None
        //         }
        //         _ => Some(e),
        //     }
        // });
    }
}

#[derive(Clone)]
enum DataEnum {
    I32(i32),
    I64(i64),
    F32(f32),
    F64(f64),
}

impl Display for DataEnum {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            DataEnum::I32(n) => write!(f, "{}", n),
            DataEnum::I64(n) => write!(f, "{}", n),
            DataEnum::F32(n) => write!(f, "{}", n),
            DataEnum::F64(n) => write!(f, "{}", n),
        };
        Ok(())
    }
}

#[derive(Clone)]
pub enum WasmEvent {
    // Each corresponds to a single wasm instruction.
    Load {
        idx: usize,
        offset: i32,
        data: DataEnum,
    },
    Store {
        offset: i32,
        data: StoreValue,
    },
    MemGrow {
        idx: usize,
        amount: i32,
    },
    TableGet {
        tableidx: usize,
        idx: i32,
        funcidx: i32,
    },
    TableSet {
        tableidx: usize,
        idx: i32,
        funcidx: i32,
    },
    TableGrow {
        idx: usize,
        amount: i32,
    },
    GlobalGet {
        idx: usize,
        value: F64,
        valtype: ValType,
    },
    GlobalSet {
        idx: usize,
        value: F64,
        valtype: ValType,
    },
    ImportCall {
        idx: i32,
        name: String,
    },
    ImportReturn {
        idx: i32,
        results: Vec<F64>,
    },
    // These do not correspond to a wasm instruction, but used to track control flow
    FuncEntry {
        idx: i32,
        params: Vec<F64>,
    },
    FuncEntryTable {
        idx: i32,
        tablename: String,
        tableidx: i32,
        params: Vec<F64>,
    },
    FuncReturn,
    ImportGlobal {
        idx: usize,
        module: String,
        name: String,
        mutable: bool,
        initial: F64,
        value: ValType,
    },
}

impl WasmEvent {
    async fn decode(reader: &mut BufReader<File>) -> Result<Self, ErrorKind> {
        let code = reader.read_u8().await.unwrap();
        let bin_code = BinCodes::from_u8(code).ok_or(ErrorKind::UnknownTrace)?;
        match bin_code {
            BinCodes::LoadI32 => WasmEvent::decode_load(reader, MemValue::I32).await,
            BinCodes::LoadI64 => WasmEvent::decode_load(reader, MemValue::I64).await,
            BinCodes::LoadF32 => WasmEvent::decode_load(reader, MemValue::F32).await,
            BinCodes::LoadF64 => WasmEvent::decode_load(reader, MemValue::F64).await,
            BinCodes::LoadI32_8 => WasmEvent::decode_load(reader, MemValue::I32).await,
            BinCodes::LoadI32_16 => WasmEvent::decode_load(reader, MemValue::I32).await,
            BinCodes::LoadI64_8 => WasmEvent::decode_load(reader, MemValue::I32).await,
            BinCodes::LoadI64_16 => WasmEvent::decode_load(reader, MemValue::I32).await,
            BinCodes::LoadI64_32 => WasmEvent::decode_load(reader, MemValue::I32).await,
            BinCodes::StoreI32 => WasmEvent::decode_store(reader, StoreValue::I32(0)).await,
            BinCodes::StoreI64 => WasmEvent::decode_store(reader, StoreValue::I64(0)).await,
            BinCodes::StoreF32 => WasmEvent::decode_store(reader, StoreValue::F32(0)).await,
            BinCodes::StoreF64 => WasmEvent::decode_store(reader, StoreValue::F64(0)).await,
            BinCodes::StoreI32_8 => WasmEvent::decode_store(reader, StoreValue::I8(0)).await,
            BinCodes::StoreI32_16 => WasmEvent::decode_store(reader, StoreValue::I16(0)).await,
            BinCodes::StoreI64_8 => WasmEvent::decode_store(reader, StoreValue::I8(0)).await,
            BinCodes::StoreI64_16 => WasmEvent::decode_store(reader, StoreValue::I16(0)).await,
            BinCodes::StoreI64_32 => WasmEvent::decode_store(reader, StoreValue::I32(0)).await,
            BinCodes::Call => WasmEvent::decode_call(reader).await,
            BinCodes::CallIndirect => todo!(),
            BinCodes::GlobalGet => todo!(),
            BinCodes::GlobalSet => todo!(),
            BinCodes::TableGet => todo!(),
            BinCodes::TableSet => todo!(),
            BinCodes::FuncReturn => todo!(),
            BinCodes::CallReturn => todo!(),
        }
    }

    async fn decode_call(reader: &mut BufReader<File>) -> Result<Self, ErrorKind> {
        let type_id = reader.read_i32().await.map_err(|_| ErrorKind::UnknownTrace)? as usize;
        // let typ = module_types.get(type_id).ok_or(ErrorKind::UnknownTrace)?;
        todo!("CONTINUE HERE NEXT TIME!!")
    }

    async fn decode_load(reader: &mut BufReader<File>, val_type: MemValue) -> Result<Self, ErrorKind> {
        let data = Self::decode_data(reader, val_type).await?;
        let offset = reader.read_i32().await.map_err(|_| ErrorKind::UnknownTrace)?;
        Ok(WasmEvent::Load { idx: 0, offset, data })
    }

    async fn decode_store(reader: &mut BufReader<File>, mut data: StoreValue) -> Result<Self, ErrorKind> {
        Self::decode_store_value(reader, &mut data).await?;
        let offset = reader.read_i32().await.map_err(|_| ErrorKind::UnknownTrace)?;
        Ok(WasmEvent::Store { offset, data })
    }

    async fn decode_store_value(reader: &mut BufReader<File>, data: &mut StoreValue) -> Result<(), ErrorKind> {
        match data {
            StoreValue::I8(v) => *v = reader.read_i8().await.map_err(|_| ErrorKind::UnknownTrace)?,
            StoreValue::I16(v) => *v = reader.read_i16().await.map_err(|_| ErrorKind::UnknownTrace)?,
            StoreValue::I32(v) => *v = reader.read_i32().await.map_err(|_| ErrorKind::UnknownTrace)?,
            StoreValue::I64(v) => *v = reader.read_i64().await.map_err(|_| ErrorKind::UnknownTrace)?,
            StoreValue::F32(v) => *v = reader.read_f32().await.map_err(|_| ErrorKind::UnknownTrace)?,
            StoreValue::F64(v) => *v = reader.read_f64().await.map_err(|_| ErrorKind::UnknownTrace)?,
        };
        Ok(())
    }

    async fn decode_data(reader: &mut BufReader<File>, val_type: MemValue) -> Result<DataEnum, ErrorKind> {
        match val_type {
            MemValue::U8 => todo!(),
            MemValue::I8 => todo!(),
            MemValue::U16 => todo!(),
            MemValue::I16 => todo!(),
            MemValue::U32 => todo!(),
            MemValue::I32 => Ok(DataEnum::I32(reader.read_i32().await.map_err(|_| ErrorKind::UnknownTrace)?)),
            MemValue::I64 => Ok(DataEnum::I64(reader.read_i64().await.map_err(|_| ErrorKind::UnknownTrace)?)),
            MemValue::F32 => Ok(DataEnum::F32(reader.read_f32().await.map_err(|_| ErrorKind::UnknownTrace)?)),
            MemValue::F64 => Ok(DataEnum::F64(reader.read_f64().await.map_err(|_| ErrorKind::UnknownTrace)?)),
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
            write!(f, "nan")
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

impl Debug for ValType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::I32 => write!(f, "i32"),
            Self::I64 => write!(f, "i64"),
            Self::F32 => write!(f, "f32"),
            Self::F64 => write!(f, "f64"),
            Self::V128 => write!(f, "v128"),
            Self::Anyref => write!(f, "anyref"),
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
                tablename: components[2].to_string(),
                tableidx: components[3].parse().unwrap(),
                params: split_list(components.get(4).unwrap()),
            }),
            "ER" => Ok(WasmEvent::FuncReturn),
            "IC" => Ok(WasmEvent::ImportCall {
                idx: components[1].parse().unwrap(),
                name: components[2].to_string(),
            }),
            "IR" => Ok(WasmEvent::ImportReturn {
                idx: components[1].parse().unwrap(),
                results: split_list(components.get(3).unwrap()),
            }),
            "L" => Ok(WasmEvent::Load {
                idx: components[1].parse().unwrap(),
                offset: components[3].parse().unwrap(),
                data: DataEnum::I32(i32::from_le_bytes(
                    split_list(components.get(4).unwrap())
                        .iter()
                        .map(|n| n.0 as u8)
                        .collect::<Vec<u8>>()
                        .try_into()
                        .unwrap(),
                )),
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
            "IG" => Ok(WasmEvent::ImportGlobal {
                idx: components[1].parse().unwrap(),
                module: components[2].to_string(),
                name: components[3].to_string(),
                value: components[4].parse().unwrap(),
                mutable: if components[5] == "1" { true } else { false },
                initial: components[6].parse().unwrap(),
            }),
            "IT" | "IM" | "IF" => Err(ErrorKind::LegacyTrace),
            _ => Err(ErrorKind::UnknownTrace),
        }
    }
}

impl Display for WasmEvent {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            WasmEvent::Load { idx, offset, data } => {
                write!(f, "L;{};{};{}", idx, offset, data)
            }
            WasmEvent::MemGrow { idx, amount } => {
                write!(f, "MG;{};{}", idx, amount)
            }
            WasmEvent::TableGet { tableidx, idx, funcidx } => {
                write!(f, "T;{};{};{}", tableidx, idx, funcidx)
            }
            WasmEvent::TableGrow { idx, amount } => {
                write!(f, "MG;{};{}", idx, amount)
            }
            WasmEvent::GlobalGet { idx, value, valtype } => {
                write!(f, "G;{};{};{:?}", idx, value, valtype)
            }
            WasmEvent::FuncEntry { params, idx } => {
                write!(f, "EC{};{}", idx, join_vec(params))
            }
            WasmEvent::FuncEntryTable { idx, tablename, tableidx: funcidx, params } => {
                write!(f, "TC;{};{};{};{}", idx, tablename, funcidx, join_vec(params),)
            }
            WasmEvent::FuncReturn => write!(f, "ER"),
            WasmEvent::ImportCall { idx, name } => write!(f, "IC;{};{}", idx, name),
            WasmEvent::ImportReturn { idx, results } => {
                write!(f, "IR;{};{}", idx, join_vec(results))
            }
            WasmEvent::ImportGlobal { idx, module, name, mutable, initial, value } => {
                write!(
                    f,
                    "IG;{};{};{};{:?};{};{}",
                    idx,
                    module,
                    name,
                    value,
                    if *mutable { '1' } else { '0' },
                    initial
                )
            }
            _ => {
                /* Ignore rest for now*/
                Ok(())
            }
        }
    }
}
