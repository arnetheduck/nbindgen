type A* = object
  namespacex*: int32
  floatx*: float32

type B* = object
  namespacex*: int32
  floatx*: float32

type C_Tag* {.size: sizeof(uint8).} = enum
  D

type D_Body* = object
  namespacex*: int32
  floatx*: float32

type C* = object
  case tag*: C_Tag

  of D:
    d*: D_Body

type E_Tag* {.size: sizeof(uint8).} = enum
  Double
  Float

type E* = object
  case tag*: E_Tag

  of Double:
    doublex*: float64
  of Float:
    floatx*: float32

type F_Tag* {.size: sizeof(uint8).} = enum
  doublex
  floatx

type F* = object
  case tag*: F_Tag

  of doublex:
    doublex*: float64
  of floatx:
    floatx*: float32

proc root*(a: A,
           b: B,
           c: C,
           e: E,
           f: F,
           namespacex: int32,
           floatx: float32): void {.importc: "root".}
