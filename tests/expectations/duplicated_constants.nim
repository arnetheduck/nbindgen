type Foo* = object
  field*: uint32

type Bar* = object
  field*: uint32

proc root*(a: Foo, b: Bar): void {.importc: "root".}
