
type Foo_1i32_2i32* = object
  xx*: int32
  xy*: int32

type IntFoo_1i32* = Foo_1i32_2i32

proc root*(a: IntFoo_1i32): void {.importc: "root".}
