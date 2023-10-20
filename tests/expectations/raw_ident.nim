type Enum* {.size: sizeof(uint8).} = enum
  a
  b

type Struct* = object
  field*: Enum

var STATIC*: Enum

proc fn*(arg: Struct): void {.importc: "fn".}
