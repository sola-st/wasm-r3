//! Trace is just a sequence of WasmEvents.
//! WasmEvent corresponds to a single event that can happen during the execution of a Wasm program.
//! Most usually corresponds to one wasm instruction, e.g. WasmEvent::Load corresponds to one wasm load,
//! but some of them are not. e.g. FuncEntry and FuncReturn correspond to the entry and return of a wasm function.
//! There are also some events that are not part of the execution like Import*, which can be removed later.
use futures::{stream, Stream, StreamExt};
use std::fmt::Debug;
use std::fmt::{self, Write};
use std::os::macos::raw;
use std::pin::Pin;
use std::str::FromStr;
use std::sync::Arc;
use std::task::{Context, Poll};
use tokio::fs::File;
use tokio::io::{self, AsyncBufReadExt, AsyncReadExt, AsyncWriteExt, BufReader, BufWriter};
use tokio::sync::mpsc::{channel, Receiver, Sender};
use walrus::ir::Load;
use walrus::Module;

#[derive(Debug)]
pub enum ErrorKind {
    LegacyTrace,
    UnknownTrace,
}

pub mod bin_format {
    pub const LOAD_I32: u8 = 0x28;
    pub const LOAD_I64: u8 = 0x29;
    pub const LOAD_F32: u8 = 0x2A;
    pub const LOAD_F64: u8 = 0x2B;
    pub const LOAD_I32_8: u8 = 0x2C;
    pub const LOAD_I32_16: u8 = 0x2E;
    pub const LOAD_I64_8: u8 = 0x30;
    pub const LOAD_I64_16: u8 = 0x32;
    pub const LOAD_I64_32: u8 = 0x34;
    pub const STORE_I32: u8 = 0x36;
    pub const STORE_I64: u8 = 0x37;
    pub const STORE_F32: u8 = 0x38;
    pub const STORE_F64: u8 = 0x39;
    pub const STORE_I32_8: u8 = 0x3A;
    pub const STORE_I32_16: u8 = 0x3B;
    pub const STORE_I64_8: u8 = 0x3C;
    pub const STORE_I64_16: u8 = 0x3D;
    pub const STORE_I64_32: u8 = 0x3E;
    pub const CALL: u8 = 0x10;
    pub const CALL_INDIRECT: u8 = 0x11;
    pub const GLOBAL_GET: u8 = 0x23;
    pub const GLOBAL_SET: u8 = 0x24;
    pub const TABLE_GET: u8 = 0x25;
    pub const TABLE_SET: u8 = 0x26;
    pub const FUNC_RETURN: u8 = 0x0F;
    // pub const MEM_GROW: u8 = 0x02;
    // pub const TABLE_GROW: u8 = 0x02;
    // pub const IMPORT_CALL: u8 = 0x02;
    // pub const IMPORT_RETURN: u8 = 0x02;
    // pub const FUNC_ENTRY: u8 = 0x02;
    // pub const FUNC_ENTRY_TABLE: u8 = 0x02;
    // pub const IMPORT_GLOBAL: u8 = 0x02;
}

pub struct Trace(Pin<Box<dyn Stream<Item = WasmEvent>>>);

impl Trace {
    pub fn from_text(file: File) -> Trace {
        let reader = BufReader::new(file);
        Trace(Box::pin(stream::unfold(reader, |mut reader| async {
            let mut buffer = String::new();
            reader.read_line(&mut buffer).await.unwrap();
            let event: WasmEvent = buffer.parse().unwrap();
            Some((event, reader))
        })))
    }

    pub fn from_binary(file: File, module: &Module) -> Trace {
        let module_types = module
            .types
            .iter()
            .map(|t| t.clone())
            .collect::<Vec<walrus::Type>>();
        let module_types_arc = Arc::new(module_types);
        let mut reader = io::BufReader::new(file);
        Trace(Box::pin(stream::unfold(reader, move |mut reader| {
            let module_types_clone = module_types_arc.clone();
            async move {
                let event = WasmEvent::decode(&mut reader, module_types_clone).await;
                Some((event, reader))
            }
        })))
    }

    // pub fn pipe<F>(&mut self, f: dyn FnMut() -> WasmEvent) {
    //     f(self.trace);
    // }

    pub fn opt_shadow_mem(&mut self) {}

    pub fn opt_shadow_table(&mut self) {}
    
    pub fn opt_shadow_global(&mut self) {}

    pub fn opt_function_entry(&mut self) {}

    pub async fn to_text(self, file: &mut File) -> Result<(), std::io::Error> {
        let mut writer = BufWriter::new(file);
        let stream = self.0;
        let mut stream = stream.map(|e| format!("{:?}", e));
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
        self.0.poll_next_unpin(cx)
    }
}

pub enum WasmEvent {
    // Each corresponds to a single wasm instruction.
    Load {
        idx: usize,
        name: String,
        offset: i32,
        data: Vec<F64>,
    },
    Store {
        offset: i32,
        data: Vec<F64>,
    },
    MemGrow {
        idx: usize,
        name: String,
        amount: i32,
    },
    TableGet {
        tableidx: usize,
        name: String,
        idx: i32,
        funcidx: i32,
        funcname: String,
    },
    TableGrow {
        idx: usize,
        name: String,
        amount: i32,
    },
    GlobalGet {
        idx: usize,
        name: String,
        value: F64,
        valtype: ValType,
    },
    ImportCall {
        idx: i32,
        name: String,
    },
    ImportReturn {
        idx: i32,
        name: String,
        results: Vec<F64>,
    },
    // These do not correspond to a wasm instruction, but used to track control flow
    FuncEntry {
        idx: i32,
        name: String,
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
    async fn decode(reader: &mut BufReader<File>, module_types: Arc<Vec<walrus::Type>>) -> Self {
        let code = reader.read_u8().await.unwrap();
        match code {
            bin_format::LOAD_I32 => WasmEvent::decode_load(reader, ValType::I32).await,
            bin_format::LOAD_I64 => WasmEvent::decode_load(reader, ValType::I64).await,
            bin_format::LOAD_F32 => WasmEvent::decode_load(reader, ValType::F32).await,
            bin_format::LOAD_F64 => WasmEvent::decode_load(reader, ValType::F64).await,
            bin_format::LOAD_I32_8 => WasmEvent::decode_load(reader, ValType::I32).await,
            bin_format::LOAD_I32_16 => WasmEvent::decode_load(reader, ValType::I32).await,
            bin_format::LOAD_I64_8 => WasmEvent::decode_load(reader, ValType::I64).await,
            bin_format::LOAD_I64_16 => WasmEvent::decode_load(reader, ValType::I64).await,
            bin_format::LOAD_I64_32 => WasmEvent::decode_load(reader, ValType::I64).await,
            bin_format::STORE_I32 => WasmEvent::decode_store(reader, ValType::I32).await,
            bin_format::STORE_I64 => WasmEvent::decode_store(reader, ValType::I64).await,
            bin_format::STORE_F32 => WasmEvent::decode_store(reader, ValType::F32).await,
            bin_format::STORE_F64 => WasmEvent::decode_store(reader, ValType::F64).await,
            bin_format::STORE_I32_8 => WasmEvent::decode_store(reader, ValType::I32).await,
            bin_format::STORE_I32_16 => WasmEvent::decode_store(reader, ValType::I32).await,
            bin_format::STORE_I64_8 => WasmEvent::decode_store(reader, ValType::I64).await,
            bin_format::STORE_I64_16 => WasmEvent::decode_store(reader, ValType::I64).await,
            bin_format::STORE_I64_32 => WasmEvent::decode_store(reader, ValType::I64).await,
            bin_format::CALL => WasmEvent::decode_call(reader, module_types).await,
            bin_format::CALL_INDIRECT => todo!(),
            bin_format::GLOBAL_GET => todo!(),
            bin_format::GLOBAL_SET => todo!(),
            bin_format::TABLE_GET => todo!(),
            bin_format::TABLE_SET => todo!(),
            bin_format::FUNC_RETURN => todo!(),
            _ => panic!("Unknown code"),
        }
    }

    async fn decode_call(
        reader: &mut BufReader<File>,
        module_types: Arc<Vec<walrus::Type>>,
    ) -> Self {
        let type_id = reader.read_i32().await.unwrap() as usize;
        let typ = module_types.get(type_id).unwrap();
        todo!("CONTINUE HERE NEXT TIME!!")
    }

    async fn decode_load(reader: &mut BufReader<File>, val_type: ValType) -> Self {
        let data = Self::decode_data(reader, val_type).await;
        let offset = reader.read_i32().await.unwrap();
        WasmEvent::Load {
            idx: 0,
            name: String::from("random"),
            offset,
            data,
        }
    }

    async fn decode_store(reader: &mut BufReader<File>, val_type: ValType) -> Self {
        let data = Self::decode_data(reader, val_type).await;
        let offset = reader.read_i32().await.unwrap();
        WasmEvent::Store { offset, data }
    }

    async fn decode_data(reader: &mut BufReader<File>, val_type: ValType) -> Vec<F64> {
        match val_type {
            ValType::I32 => reader
                .read_i32()
                .await
                .unwrap()
                .to_le_bytes()
                .to_vec()
                .into_iter()
                .map(|b| F64(b as f64))
                .collect(),
            ValType::I64 => reader
                .read_i64()
                .await
                .unwrap()
                .to_le_bytes()
                .to_vec()
                .into_iter()
                .map(|b| F64(b as f64))
                .collect(),
            ValType::F32 => reader
                .read_f32()
                .await
                .unwrap()
                .to_le_bytes()
                .to_vec()
                .into_iter()
                .map(|b| F64(b as f64))
                .collect(),
            ValType::F64 => reader
                .read_f64()
                .await
                .unwrap()
                .to_le_bytes()
                .to_vec()
                .into_iter()
                .map(|b| F64(b as f64))
                .collect(),
            ValType::V128 => todo!(),
            ValType::Anyref => todo!(),
            ValType::Externref => todo!(),
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

fn from_short_str(s: &str) -> Result<ValType, ()> {
    match s {
        "i" => Ok(ValType::I32),
        "I" => Ok(ValType::I64),
        "f" => Ok(ValType::F32),
        "F" => Ok(ValType::F64),
        _ => Err(()),
    }
}

fn join_vec(args: &Vec<F64>) -> String {
    args.iter()
        .map(|x| x.to_string())
        .collect::<Vec<String>>()
        .join(",")
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

fn parse_tys(s: &str) -> Vec<ValType> {
    let mut tys = vec![];
    for ty in s.chars() {
        tys.push(from_short_str(&ty.to_string()).unwrap());
    }
    tys
}

impl FromStr for WasmEvent {
    type Err = ErrorKind;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        fn split_list(c: &str) -> Vec<F64> {
            let list = c
                .split(',')
                .filter_map(|s| parse_number(s))
                .collect::<Vec<_>>();
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
                name: components[2].to_string(),
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
                name: components[2].to_string(),
                results: split_list(components.get(3).unwrap()),
            }),
            "L" => Ok(WasmEvent::Load {
                idx: components[1].parse().unwrap(),
                name: components[2].to_string(),
                offset: components[3].parse().unwrap(),
                data: split_list(components.get(4).unwrap()),
            }),
            "MG" => Ok(WasmEvent::MemGrow {
                idx: components[1].parse().unwrap(),
                name: components[2].to_string(),
                amount: components[3].parse().unwrap(),
            }),
            "T" => Ok(WasmEvent::TableGet {
                tableidx: components[1].parse().unwrap(),
                name: components[2].to_string(),
                idx: components[3].parse().unwrap(),
                funcidx: components[4].parse().unwrap(),
                funcname: components[5].to_string(),
            }),
            "TG" => Ok(WasmEvent::TableGrow {
                idx: components[1].parse().unwrap(),
                name: components[2].to_string(),
                amount: components[3].parse().unwrap(),
            }),
            "G" => Ok(WasmEvent::GlobalGet {
                idx: components[1].parse().unwrap(),
                name: components[2].to_string(),
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

impl Debug for WasmEvent {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            WasmEvent::Load {
                idx,
                name,
                offset,
                data,
            } => write!(f, "L;{};{};{};{}", idx, name, offset, join_vec(data)),
            WasmEvent::MemGrow { idx, name, amount } => {
                write!(f, "MG;{};{};{}", idx, name, amount)
            }
            WasmEvent::TableGet {
                tableidx,
                name,
                idx,
                funcidx,
                funcname,
            } => {
                write!(
                    f,
                    "T;{};{};{};{};{}",
                    tableidx, name, idx, funcidx, funcname
                )
            }
            WasmEvent::TableGrow { idx, name, amount } => {
                write!(f, "MG;{};{};{}", idx, name, amount)
            }
            WasmEvent::GlobalGet {
                idx,
                name,
                value,
                valtype,
            } => {
                write!(f, "G;{};{};{};{:?}", idx, name, value, valtype)
            }
            WasmEvent::FuncEntry { name, params, idx } => {
                write!(f, "EC{};{};{}", idx, name, join_vec(params))
            }
            WasmEvent::FuncEntryTable {
                idx,
                tablename,
                tableidx: funcidx,
                params,
            } => write!(
                f,
                "TC;{};{};{};{}",
                idx,
                tablename,
                funcidx,
                join_vec(params),
            ),
            WasmEvent::FuncReturn => write!(f, "ER"),
            WasmEvent::ImportCall { idx, name } => write!(f, "IC;{};{}", idx, name),
            WasmEvent::ImportReturn { idx, name, results } => {
                write!(f, "IR;{};{};{}", idx, name, join_vec(results),)
            }
            WasmEvent::ImportGlobal {
                idx,
                module,
                name,
                mutable,
                initial,
                value,
            } => {
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

// impl Trace {
//     async fn from_stream<T>(mut stream: T) -> io::Result<Self>
//     where
//         T: AsyncRead + Unpin,
//     {
//         let mut buf = [0; 1];
//         stream.read_exact(&mut buf);
//         match buf[0] {
//             0x00 => todo!(),
//             _ => panic!(),
//         };
//         todo!()
//     }
// }
