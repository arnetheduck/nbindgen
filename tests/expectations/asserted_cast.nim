type I* {.incompleteStruct.} = object

type H_Tag* {.size: sizeof(uint8).} = enum
  H_Foo
  H_Bar
  H_Baz

type H_Bar_Body* = object
  x*: uint8
  y*: int16

type H* = object
  case tag*: H_Tag

  of H_Foo:
    foo*: int16
  of H_Bar:
    bar*: H_Bar_Body
  else: discard

type J_Tag* {.size: sizeof(uint8).} = enum
  J_Foo
  J_Bar
  J_Baz

type J_Bar_Body* = object
  x*: uint8
  y*: int16

type J* = object
  case tag*: J_Tag

  of J_Foo:
    foo*: int16
  of J_Bar:
    bar*: J_Bar_Body
  else: discard

type K_Tag* {.size: sizeof(uint8).} = enum
  K_Foo
  K_Bar
  K_Baz

type K_Bar_Body* = object
  tag*: K_Tag
  x*: uint8
  y*: int16

type K* = object
  case tag*: K_Tag

  of K_Foo:
    foo_tag*: K_Tag
    foo*: int16
  of K_Bar:
    bar*: K_Bar_Body
  else: discard

proc foo*(h: H, i: I, j: J, k: K): void {.importc: "foo".}
