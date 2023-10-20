type Bar* = enum
  BarSome
  BarThing

type FooU8* = object
  a*: uint8

type Boo* = FooU8

proc root*(x: Boo, y: Bar): void {.importc: "root".}

proc unsafe_root*(x: Boo, y: Bar): void {.importc: "unsafe_root".}
