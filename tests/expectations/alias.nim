
type Status* {.size: sizeof(uint32).} = enum
  Ok
  Err

type Dep* = object
  xa*: int32
  xb*: float32

type Foo_1i32* = object
  xa*: int32
  xb*: int32
  xc*: Dep

type IntFoo* = Foo_1i32

type Foo_1f64* = object
  xa*: float64
  xb*: float64
  xc*: Dep

type DoubleFoo* = Foo_1f64

type Unit* = int32

type SpecialStatus* = Status

proc root*(x: IntFoo, y: DoubleFoo, z: Unit, w: SpecialStatus): void {.importc: "root".}
