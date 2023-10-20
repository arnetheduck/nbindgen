type Status* {.size: sizeof(uint32).} = enum
  Ok
  Err

type Dep* = object
  a*: int32
  b*: float32

type Foo_i32* = object
  a*: int32
  b*: int32
  c*: Dep

type IntFoo* = Foo_i32

type Foo_f64* = object
  a*: float64
  b*: float64
  c*: Dep

type DoubleFoo* = Foo_f64

type Unit* = int32

type SpecialStatus* = Status

proc root*(x: IntFoo, y: DoubleFoo, z: Unit, w: SpecialStatus): void {.importc: "root".}
