
type Foo* = object
  xa*: bool
  xb*: int32

type Bar_Tag* {.size: sizeof(uint8).} = enum
  Baz
  Bazz
  FooNamed
  FooParen

type Bazz_Body* = object
  xnamed*: Bar_Tag

type FooNamed_Body* = object
  xdifferent*: Bar_Tag
  xfields*: uint32

type FooParen_Body* = object
  x0*: Bar_Tag
  x1*: Foo

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
