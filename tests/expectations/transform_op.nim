type StylePoint_i32* = object
  x*: int32
  y*: int32

type StylePoint_f32* = object
  x*: float32
  y*: float32

type StyleFoo_i32_Tag* {.size: sizeof(uint8).} = enum
  Foo_i32
  Bar_i32
  Baz_i32
  Bazz_i32

type StyleFoo_Body_i32* = object
  tag*: StyleFoo_i32_Tag
  x*: int32
  y*: StylePoint_i32
  z*: StylePoint_f32

type StyleFoo_i32* = object
  case tag*: StyleFoo_i32_Tag

  of Foo_i32:
    foo*: StyleFoo_Body_i32
  of Bar_i32:
    bar_tag*: StyleFoo_i32_Tag
    bar*: int32
  of Baz_i32:
    baz_tag*: StyleFoo_i32_Tag
    baz*: StylePoint_i32
  else: discard

type StyleBar_i32_Tag* = enum
  Bar1_i32
  Bar2_i32
  Bar3_i32
  Bar4_i32

type StyleBar1_Body_i32* = object
  x*: int32
  y*: StylePoint_i32
  z*: StylePoint_f32
  u*: proc(a0: int32): int32

type StyleBar_i32* = object
  case tag*: StyleBar_i32_Tag

  of Bar1_i32:
    bar1*: StyleBar1_Body_i32
  of Bar2_i32:
    bar2*: int32
  of Bar3_i32:
    bar3*: StylePoint_i32
  else: discard

type StylePoint_u32* = object
  x*: uint32
  y*: uint32

type StyleBar_u32_Tag* = enum
  Bar1_u32
  Bar2_u32
  Bar3_u32
  Bar4_u32

type StyleBar1_Body_u32* = object
  x*: int32
  y*: StylePoint_u32
  z*: StylePoint_f32
  u*: proc(a0: int32): int32

type StyleBar_u32* = object
  case tag*: StyleBar_u32_Tag

  of Bar1_u32:
    bar1*: StyleBar1_Body_u32
  of Bar2_u32:
    bar2*: uint32
  of Bar3_u32:
    bar3*: StylePoint_u32
  else: discard

type StyleBaz_Tag* {.size: sizeof(uint8).} = enum
  Baz1
  Baz2
  Baz3

type StyleBaz* = object
  case tag*: StyleBaz_Tag

  of Baz1:
    baz1_tag*: StyleBaz_Tag
    baz1*: StyleBar_u32
  of Baz2:
    baz2_tag*: StyleBaz_Tag
    baz2*: StylePoint_i32
  else: discard

type StyleTaz_Tag* {.size: sizeof(uint8).} = enum
  Taz1
  Taz2
  Taz3

type StyleTaz* = object
  case tag*: StyleTaz_Tag

  of Taz1:
    taz1*: StyleBar_u32
  of Taz2:
    taz2*: StyleBaz
  else: discard

proc foo*(foo: ptr StyleFoo_i32,
          bar: ptr StyleBar_i32,
          baz: ptr StyleBaz,
          taz: ptr StyleTaz): void {.importc: "foo".}
