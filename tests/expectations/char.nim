
type Foo* = object
  xa*: uint32

proc root*(a: Foo): void {.importc: "root".}
