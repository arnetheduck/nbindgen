type C* {.size: sizeof(uint32).} = enum
  X
  Y

type A* = object
  m0*: int32

type B* = object
  x*: int32
  y*: float32

type F_Tag* {.size: sizeof(uint8).} = enum
  Foo
  Bar
  Baz

type Bar_Body* = object
  tag*: F_Tag
  x*: uint8
  y*: int16

type F* = object
  case tag*: F_Tag

  of Foo:
    foo_tag*: F_Tag
    foo*: int16
  of Bar:
    bar*: Bar_Body
  else: discard

type H_Tag* {.size: sizeof(uint8).} = enum
  Hello
  There
  Everyone

type There_Body* = object
  x*: uint8
  y*: int16

type H* = object
  case tag*: H_Tag

  of Hello:
    hello*: int16
  of There:
    there*: There_Body
  else: discard

proc root*(x: A, y: B, z: C, f: F, h: H): void {.importc: "root".}
