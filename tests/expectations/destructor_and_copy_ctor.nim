#define NOINLINE __attribute__((noinline))
#define NODISCARD [[nodiscard]]




type FillRule* {.size: sizeof(uint8).} = enum
  A
  B

## This will have a destructor manually implemented via variant_body, and
# similarly a Drop impl in Rust.
type OwnedSlice_1u32* = object
  xlen*: uint
  xptr*: pointer

type Polygon_1u32* = object
  xfill*: FillRule
  xcoordinates*: OwnedSlice_1u32

## This will have a destructor manually implemented via variant_body, and
# similarly a Drop impl in Rust.
type OwnedSlice_1i32* = object
  xlen*: uint
  xptr*: pointer

type Foo_1u32_Tag* {.size: sizeof(uint8).} = enum
  Bar_1u32
  Polygon1_1u32
  Slice1_1u32
  Slice2_1u32
  Slice3_1u32
  Slice4_1u32

type Slice3_Body_1u32* = object
  xfill*: FillRule
  xcoords*: OwnedSlice_1u32

type Slice4_Body_1u32* = object
  xfill*: FillRule
  xcoords*: OwnedSlice_1i32

type Foo_1u32* = object
  case tag*: Foo_1u32_Tag

  of Polygon1_1u32:
    xpolygon1*: Polygon_1u32
  of Slice1_1u32:
    xslice1*: OwnedSlice_1u32
  of Slice2_1u32:
    xslice2*: OwnedSlice_1i32
  of Slice3_1u32:
    slice3*: Slice3_Body_1u32
  of Slice4_1u32:
    slice4*: Slice4_Body_1u32
  else: discard

type Baz_1i32_Tag* {.size: sizeof(uint8).} = enum
  Bar2_1i32
  Polygon21_1i32
  Slice21_1i32
  Slice22_1i32
  Slice23_1i32
  Slice24_1i32

type Slice23_Body_1i32* = object
  xfill*: Baz_1i32_Tag
  xcoords*: OwnedSlice_1i32

type Slice24_Body_1i32* = object
  xfill*: Baz_1i32_Tag
  xcoords*: OwnedSlice_1i32

type Baz_1i32* = object
  case tag*: Baz_1i32_Tag

  of Polygon21_1i32:
    xpolygon21*: Baz_1i32_Tag
  of Slice21_1i32:
    xslice21*: Baz_1i32_Tag
  of Slice22_1i32:
    xslice22*: Baz_1i32_Tag
  of Slice23_1i32:
    slice23*: Slice23_Body_1i32
  of Slice24_1i32:
    slice24*: Slice24_Body_1i32
  else: discard

type Taz_Tag* {.size: sizeof(uint8).} = enum
  Bar3
  Taz1
  Taz3

type Taz* = object
  case tag*: Taz_Tag

  of Taz1:
    xtaz1*: Taz_Tag
  of Taz3:
    xtaz3*: Taz_Tag
  else: discard

type Tazz_Tag* {.size: sizeof(uint8).} = enum
  Bar4
  Taz2

type Tazz* = object
  case tag*: Tazz_Tag

  of Taz2:
    xtaz2*: Tazz_Tag
  else: discard

type Tazzz_Tag* {.size: sizeof(uint8).} = enum
  Bar5
  Taz5

type Tazzz* = object
  case tag*: Tazzz_Tag

  of Taz5:
    xtaz5*: Tazzz_Tag
  else: discard

type Tazzzz_Tag* {.size: sizeof(uint8).} = enum
  Taz6
  Taz7

type Tazzzz* = object
  case tag*: Tazzzz_Tag

  of Taz6:
    xtaz6*: Tazzzz_Tag
  of Taz7:
    xtaz7*: Tazzzz_Tag

type Qux_Tag* {.size: sizeof(uint8).} = enum
  Qux1
  Qux2

type Qux* = object
  case tag*: Qux_Tag

  of Qux1:
    xqux1*: Qux_Tag
  of Qux2:
    xqux2*: Qux_Tag

proc root*(a: ptr Foo_1u32,
           b: ptr Baz_1i32,
           c: ptr Taz,
           d: Tazz,
           e: ptr Tazzz,
           f: ptr Tazzzz,
           g: ptr Qux): void {.importc: "root".}
