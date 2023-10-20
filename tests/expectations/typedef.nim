type Foo_i32_i32* = object
  x*: int32
  y*: int32

type IntFoo_i32* = Foo_i32_i32

proc root*(a: IntFoo_i32): void {.importc: "root".}
