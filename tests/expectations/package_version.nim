type Foo* = object
  bar*: uint64

proc doit*(a0: ptr Foo): void {.importc: "doit".}
