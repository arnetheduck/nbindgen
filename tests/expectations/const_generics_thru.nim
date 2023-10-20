
type Inner_11* = object
  xbytes*: uint8

type Outer_11* = object
  xinner*: Inner_11

type Inner_12* = object
  xbytes*: uint8

type Outer_12* = object
  xinner*: Inner_12

proc one*(): Outer_11 {.importc: "one".}

proc two*(): Outer_12 {.importc: "two".}
