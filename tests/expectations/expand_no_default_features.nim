
type Foo* = object


proc root*(a: Foo): void {.importc: "root".}
