type FillRule* {.size: sizeof(uint8).} = enum
  A
  B

## This will have a destructor manually implemented via variant_body, and
# similarly a Drop impl in Rust.
type OwnedSlice_u32* = object
  len*: uint
  ptrx*: pointer

type Polygon_u32* = object
  fill*: FillRule
  coordinates*: OwnedSlice_u32

## This will have a destructor manually implemented via variant_body, and
# similarly a Drop impl in Rust.
type OwnedSlice_i32* = object
  len*: uint
  ptrx*: pointer

type Foo_u32_Tag* {.size: sizeof(uint8).} = enum
  Bar_u32
  Polygon1_u32
  Slice1_u32
  Slice2_u32
  Slice3_u32
  Slice4_u32

type Slice3_Body_u32* = object
  fill*: FillRule
  coords*: OwnedSlice_u32

type Slice4_Body_u32* = object
  fill*: FillRule
  coords*: OwnedSlice_i32

type Foo_u32* = object
  case tag*: Foo_u32_Tag

  of Polygon1_u32:
    polygon1*: Polygon_u32
  of Slice1_u32:
    slice1*: OwnedSlice_u32
  of Slice2_u32:
    slice2*: OwnedSlice_i32
  of Slice3_u32:
    slice3*: Slice3_Body_u32
  of Slice4_u32:
    slice4*: Slice4_Body_u32
  else: discard

type Polygon_i32* = object
  fill*: FillRule
  coordinates*: OwnedSlice_i32

type Baz_i32_Tag* {.size: sizeof(uint8).} = enum
  Bar2_i32
  Polygon21_i32
  Slice21_i32
  Slice22_i32
  Slice23_i32
  Slice24_i32

type Slice23_Body_i32* = object
  tag*: Baz_i32_Tag
  fill*: FillRule
  coords*: OwnedSlice_i32

type Slice24_Body_i32* = object
  tag*: Baz_i32_Tag
  fill*: FillRule
  coords*: OwnedSlice_i32

type Baz_i32* = object
  case tag*: Baz_i32_Tag

  of Polygon21_i32:
    polygon21_tag*: Baz_i32_Tag
    polygon21*: Polygon_i32
  of Slice21_i32:
    slice21_tag*: Baz_i32_Tag
    slice21*: OwnedSlice_i32
  of Slice22_i32:
    slice22_tag*: Baz_i32_Tag
    slice22*: OwnedSlice_i32
  of Slice23_i32:
    slice23*: Slice23_Body_i32
  of Slice24_i32:
    slice24*: Slice24_Body_i32
  else: discard

type Taz_Tag* {.size: sizeof(uint8).} = enum
  Bar3
  Taz1
  Taz3

type Taz* = object
  case tag*: Taz_Tag

  of Taz1:
    taz1_tag*: Taz_Tag
    taz1*: int32
  of Taz3:
    taz3_tag*: Taz_Tag
    taz3*: OwnedSlice_i32
  else: discard

type Tazz_Tag* {.size: sizeof(uint8).} = enum
  Bar4
  Taz2

type Tazz* = object
  case tag*: Tazz_Tag

  of Taz2:
    taz2_tag*: Tazz_Tag
    taz2*: int32
  else: discard

type Tazzz_Tag* {.size: sizeof(uint8).} = enum
  Bar5
  Taz5

type Tazzz* = object
  case tag*: Tazzz_Tag

  of Taz5:
    taz5_tag*: Tazzz_Tag
    taz5*: int32
  else: discard

type Tazzzz_Tag* {.size: sizeof(uint8).} = enum
  Taz6
  Taz7

type Tazzzz* = object
  case tag*: Tazzzz_Tag

  of Taz6:
    taz6_tag*: Tazzzz_Tag
    taz6*: int32
  of Taz7:
    taz7_tag*: Tazzzz_Tag
    taz7*: uint32

type Qux_Tag* {.size: sizeof(uint8).} = enum
  Qux1
  Qux2

type Qux* = object
  case tag*: Qux_Tag

  of Qux1:
    qux1_tag*: Qux_Tag
    qux1*: int32
  of Qux2:
    qux2_tag*: Qux_Tag
    qux2*: uint32

proc root*(a: ptr Foo_u32,
           b: ptr Baz_i32,
           c: ptr Taz,
           d: Tazz,
           e: ptr Tazzz,
           f: ptr Tazzzz,
           g: ptr Qux): void {.importc: "root".}
