
type Foo_1_4u8* = object
  xa*: pointer

type Boo* = Foo_1_4u8

proc root*(x: Boo): void {.importc: "root".}
