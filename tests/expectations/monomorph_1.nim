
type Bar_1Bar_1f32* {.incompleteStruct.} = object

type Bar_1Foo_1f32* {.incompleteStruct.} = object

type Bar_1f32* {.incompleteStruct.} = object

type Foo_1i32* = object
  xdata*: pointer

type Foo_1f32* = object
  xdata*: pointer

type Foo_1Bar_1f32* = object
  xdata*: ptr Bar_1f32

type Tuple_1Foo_1f32_3_2f32* = object
  xa*: ptr Foo_1f32
  xb*: pointer

type Tuple_1f32_2f32* = object
  xa*: pointer
  xb*: pointer

type Indirection_1f32* = Tuple_1f32_2f32

proc root*(a: Foo_1i32,
           b: Foo_1f32,
           c: Bar_1f32,
           d: Foo_1Bar_1f32,
           e: Bar_1Foo_1f32,
           f: Bar_1Bar_1f32,
           g: Tuple_1Foo_1f32_3_2f32,
           h: Indirection_1f32): void {.importc: "root".}
