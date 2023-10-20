#define MY_ASSERT(...) do { } while (0)
#define MY_ATTRS __attribute((noinline))




type I* {.incompleteStruct.} = object

type H_Tag* {.size: sizeof(uint8).} = enum
  H_Foo
  H_Bar
  H_Baz

type H_Bar_Body* = object
  xx*: uint8
  xy*: int16

type H* = object
  case tag*: H_Tag

  of H_Foo:
    xfoo*: int16
  of H_Bar:
    bar*: H_Bar_Body
  else: discard

type J_Tag* {.size: sizeof(uint8).} = enum
  J_Foo
  J_Bar
  J_Baz

type J_Bar_Body* = object
  xx*: uint8
  xy*: int16

type J* = object
  case tag*: J_Tag

  of J_Foo:
    xfoo*: int16
  of J_Bar:
    bar*: J_Bar_Body
  else: discard

type K_Tag* {.size: sizeof(uint8).} = enum
  K_Foo
  K_Bar
  K_Baz

type K_Bar_Body* = object
  xx*: K_Tag
  xy*: int16

type K* = object
  case tag*: K_Tag

  of K_Foo:
    xfoo*: K_Tag
  of K_Bar:
    bar*: K_Bar_Body
  else: discard

proc foo*(h: H, i: I, j: J, k: K): void {.importc: "foo".}
