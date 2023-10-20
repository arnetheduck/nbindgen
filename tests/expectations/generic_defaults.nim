type Foo_i16* = int16

type Foo_i32* = int32

type Bar_i32_u32* = object
  f*: Foo_i32
  p*: uint32

type Foo_i64* = int64

type Baz_i64* = Foo_i64

type NeverUsedWithDefault_i32* = object
  field*: int32

proc foo_root*(f: Foo_i16, b: Bar_i32_u32, z: Baz_i64): void {.importc: "foo_root".}

proc with_i32*(x: NeverUsedWithDefault_i32): void {.importc: "with_i32".}
