type Foo* = object
  x*: float32

proc root*(a: Foo): void {.importc: "root".}
