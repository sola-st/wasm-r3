//! Trace is just a sequence of WasmEvents.
//! WasmEvent corresponds to a single event that can happen during the execution of a Wasm program.
//! Most usually corresponds to one wasm instruction, e.g. WasmEvent::Load corresponds to one wasm load,
//! but some of them are not. e.g. FuncEntry and FuncReturn correspond to the entry and return of a wasm function.
//! There are also some events that are not part of the execution like Import*, which can be removed later.
use std::fmt::Debug;
use std::fmt::{self, Write};
use std::str::FromStr;

pub type Trace = Vec<WasmEvent>;

pub enum WasmEvent {
    // Each corresponds to a single wasm instruction.
    Load {
        idx: usize,
        offset: i32,
        data: Vec<F64>,
    },
    MemGrow {
        idx: usize,
        amount: i32,
    },
    TableGet {
        tableidx: usize,
        name: String,
        idx: i32,
        funcidx: usize,
        funcname: String,
    },
    TableGrow {
        idx: usize,
        name: String,
        amount: i32,
    },
    GlobalGet {
        idx: usize,
        value: F64,
    },
    ImportCall {
        idx: usize,
    },
    ImportReturn {
        idx: i32,
        results: Vec<F64>,
    },
    // These do not correspond to a wasm instruction, but used to track control flow
    FuncEntry {
        idx: usize,
        name: String,
        params: Vec<F64>,
    },
    FuncEntryTable {
        idx: usize,
        tablename: String,
        tableidx: i32,
        params: Vec<F64>,
    },
    FuncReturn,
    ImportGlobal {
        idx: usize,
        initial: F64,
    },
}

pub fn encode_trace(trace: Trace) -> Result<String, std::fmt::Error> {
    let mut s = String::new();
    for event in trace {
        write!(&mut s, "{:?}\n", event)?;
    }
    Ok(s)
}

#[derive(Copy, Debug, Clone, PartialEq)]
pub struct F64(pub f64);

impl F64 {
    pub fn to_wat(&self) -> String {
        if self.0.is_infinite() {
            "inf".to_string()
        } else if self.0.is_nan() {
            "nan".to_string()
        } else {
            self.0.to_string()
        }
    }
    pub fn to_js(&self) -> String {
        if self.0.is_infinite() {
            "Infinity".to_string()
        } else if self.0.is_nan() {
            "NaN".to_string()
        } else {
            self.0.to_string()
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

#[derive(Clone, PartialEq, Debug)]
pub enum ValType {
    I32,
    I64,
    F32,
    F64,
    V128,
    Funcref,
    Externref,
}

impl ValType {
    pub fn to_wat(&self) -> &'static str {
        match self {
            Self::I32 => "i32",
            Self::I64 => "i64",
            Self::F32 => "f32",
            Self::F64 => "f64",
            Self::V128 => "v128",
            Self::Funcref => "funcref",
            Self::Externref => "externref",
        }
    }

    pub fn to_js(&self) -> &'static str {
        match self {
            Self::I32 => "i32",
            Self::I64 => "i64",
            Self::F32 => "f32",
            Self::F64 => "f64",
            Self::V128 => "v128",
            Self::Funcref => "anyfunc",
            Self::Externref => "externref",
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
            "funcref" => Ok(Self::Funcref),
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
            walrus::ValType::Ref(refty) => match refty {
                walrus::RefType::Funcref => Self::Funcref,
                walrus::RefType::Externref => Self::Externref,
                _ => todo!(),
            },
        }
    }
}

fn join_vec(args: &Vec<F64>) -> String {
    args.iter()
        .map(|x| x.to_js())
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
                let round_trip = num.to_string();
                if round_trip != s {
                    eprintln!("WARNING: roundtrip of {s}: {round_trip}");
                }
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
    assert_ne!(s, parse_number(s).unwrap().to_js());

    // problematic cases where the number is too big or too small to be handled by f64
    let small_number = "-9223372036854775808";
    let big_number = "9223372036854775807";
    assert_ne!(small_number, parse_number(small_number).unwrap().to_js());
    assert_ne!(big_number, parse_number(big_number).unwrap().to_js());
}

#[derive(Debug)]
pub enum ErrorKind {
    LegacyTrace,
    UnknownTrace,
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
            }),
            "IR" => Ok(WasmEvent::ImportReturn {
                idx: components[1].parse().unwrap(),
                results: split_list(components.get(2).unwrap()),
            }),
            "L" => Ok(WasmEvent::Load {
                idx: components[1].parse().unwrap(),
                offset: components[2].parse().unwrap(),
                data: split_list(components.get(3).unwrap()),
            }),
            "MG" => Ok(WasmEvent::MemGrow {
                idx: components[1].parse().unwrap(),
                amount: components[2].parse().unwrap(),
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
                value: parse_number(components[2]).unwrap(),
            }),
            "IG" => Ok(WasmEvent::ImportGlobal {
                idx: components[1].parse().unwrap(),
                initial: components[2].parse().unwrap(),
            }),
            "IT" | "IM" | "IF" => Err(ErrorKind::LegacyTrace),
            _ => Err(ErrorKind::UnknownTrace),
        }
    }
}

impl Debug for WasmEvent {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            WasmEvent::Load { idx, offset, data } => {
                let joined = join_vec(data);
                write!(f, "L;{idx};{offset};{joined}")
            }
            WasmEvent::MemGrow { idx, amount } => {
                write!(f, "MG;{idx};{amount}")
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
            WasmEvent::GlobalGet { idx, value } => {
                let value = value.to_js();
                write!(f, "G;{idx};{value}")
            }
            WasmEvent::FuncEntry { name, params, idx } => {
                write!(f, "EC{};{};{}", idx, name, join_vec(params))
            }
            WasmEvent::FuncEntryTable {
                idx,
                tablename,
                tableidx: funcidx,
                params,
            } => {
                write!(
                    f,
                    "TC;{};{};{};{}",
                    idx,
                    tablename,
                    funcidx,
                    join_vec(params),
                )
            }
            WasmEvent::FuncReturn => write!(f, "ER"),
            WasmEvent::ImportCall { idx } => write!(f, "IC;{idx}"),
            WasmEvent::ImportReturn { idx, results } => {
                let results = join_vec(results);
                write!(f, "IR;{idx};{results}")
            }
            WasmEvent::ImportGlobal { idx, initial } => {
                let initial = initial.to_js();
                write!(f, "IG;{idx};{initial}",)
            }
        }
    }
}
