type Bar_Bar_f32* {.incompleteStruct.} = object

type Bar_Foo_f32* {.incompleteStruct.} = object

type Bar_f32* {.incompleteStruct.} = object

type Foo_i32* = object
  data*: pointer

type Foo_f32* = object
  data*: pointer

type Foo_Bar_f32* = object
  data*: ptr Bar_f32

type Tuple_Foo_f32_f32* = object
  a*: ptr Foo_f32
  b*: pointer

type Tuple_f32_f32* = object
  a*: pointer
  b*: pointer

type Indirection_f32* = Tuple_f32_f32

proc root*(a: Foo_i32,
           b: Foo_f32,
           c: Bar_f32,
           d: Foo_Bar_f32,
           e: Bar_Foo_f32,
           f: Bar_Bar_f32,
           g: Tuple_Foo_f32_f32,
           h: Indirection_f32): void {.importc: "root".}
