type Foo* = object


proc root*(x: Foo): void {.importc: "root".}
