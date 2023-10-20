type Foo_u8* = object
  a*: pointer

type Boo* = Foo_u8

type Foo_u8_4* = object
  a*: uint8

proc root*(x: Boo): void {.importc: "root".}

proc my_function*(x: Foo_u8_4): void {.importc: "my_function".}
