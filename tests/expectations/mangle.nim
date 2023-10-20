
type Bar* = enum
  BarSome
  BarThing

type FooU8* = object
  xa*: uint8

type Boo* = FooU8

proc root*(x: Boo, y: Bar): void {.importc: "root".}
