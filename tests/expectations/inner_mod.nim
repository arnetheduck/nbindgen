
type Foo* = object
  xx*: float32

proc root*(a: Foo): void {.importc: "root".}
