type Foo* = object
  a*: bool
  b*: int32

type Bar_Tag* {.size: sizeof(uint8).} = enum
  Baz
  Bazz
  FooNamed
  FooParen

type Bazz_Body* = object
  tag*: Bar_Tag
  named*: Foo

type FooNamed_Body* = object
  tag*: Bar_Tag
  different*: int32
  fields*: uint32

type FooParen_Body* = object
  tag*: Bar_Tag
  x_0*: int32
  x_1*: Foo

type Bar* = object
  case tag*: Bar_Tag

  of Bazz:
    bazz*: Bazz_Body
  of FooNamed:
    foo_named*: FooNamed_Body
  of FooParen:
    foo_paren*: FooParen_Body
  else: discard

proc root*(aBar: Bar): Foo {.importc: "root".}
