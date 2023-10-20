
type Foo_Tag* = enum
  A

type Foo* = object
  case tag*: Foo_Tag

  of A:
    xa*: float32

proc root*(a: Foo): void {.importc: "root".}
