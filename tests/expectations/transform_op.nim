
type Point_1i32* = object
  xx*: int32
  xy*: int32

type Point_1f32* = object
  xx*: float32
  xy*: float32

type StyleFoo_1i32_Tag* {.size: sizeof(uint8).} = enum
  Foo_1i32
  Bar_1i32
  Baz_1i32
  Bazz_1i32

type Foo_Body_1i32* = object
  xx*: StyleFoo_1i32_Tag
  xy*: StylePoint_1i32
  xz*: StylePoint_1f32

type StyleFoo_1i32* = object
  case tag*: StyleFoo_1i32_Tag

  of Foo_1i32:
    foo*: Foo_Body_1i32
  of Bar_1i32:
    xbar*: StyleFoo_1i32_Tag
  of Baz_1i32:
    xbaz*: StyleFoo_1i32_Tag
  else: discard

type StyleBar_1i32_Tag* = enum
  Bar1_1i32
  Bar2_1i32
  Bar3_1i32
  Bar4_1i32

type Bar1_Body_1i32* = object
  xx*: int32
  xy*: StylePoint_1i32
  xz*: StylePoint_1f32
  xu*: proc(a0: int32): int32

type StyleBar_1i32* = object
  case tag*: StyleBar_1i32_Tag

  of Bar1_1i32:
    bar1*: Bar1_Body_1i32
  of Bar2_1i32:
    xbar2*: int32
  of Bar3_1i32:
    xbar3*: StylePoint_1i32
  else: discard

type StyleBaz_Tag* {.size: sizeof(uint8).} = enum
  Baz1
  Baz2
  Baz3

type StyleBaz* = object
  case tag*: StyleBaz_Tag

  of Baz1:
    xbaz1*: StyleBaz_Tag
  of Baz2:
    xbaz2*: StyleBaz_Tag
  else: discard

type Point_1u32* = object
  xx*: uint32
  xy*: uint32

type StyleBar_1u32_Tag* = enum
  Bar1_1u32
  Bar2_1u32
  Bar3_1u32
  Bar4_1u32

type Bar1_Body_1u32* = object
  xx*: int32
  xy*: StylePoint_1u32
  xz*: StylePoint_1f32
  xu*: proc(a0: int32): int32

type StyleBar_1u32* = object
  case tag*: StyleBar_1u32_Tag

  of Bar1_1u32:
    bar1*: Bar1_Body_1u32
  of Bar2_1u32:
    xbar2*: uint32
  of Bar3_1u32:
    xbar3*: StylePoint_1u32
  else: discard

type StyleTaz_Tag* {.size: sizeof(uint8).} = enum
  Taz1
  Taz2
  Taz3

type StyleTaz* = object
  case tag*: StyleTaz_Tag

  of Taz1:
    xtaz1*: StyleBar_1u32
  of Taz2:
    xtaz2*: StyleBaz
  else: discard

proc foo*(foo: ptr StyleFoo_1i32,
          bar: ptr StyleBar_1i32,
          baz: ptr StyleBaz,
          taz: ptr StyleTaz): void {.importc: "foo".}
