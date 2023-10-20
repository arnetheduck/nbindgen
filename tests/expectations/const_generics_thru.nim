type Inner_1* = object
  bytes*: uint8

type Outer_1* = object
  inner*: Inner_1

type Inner_2* = object
  bytes*: uint8

type Outer_2* = object
  inner*: Inner_2

proc one*(): Outer_1 {.importc: "one".}

proc two*(): Outer_2 {.importc: "two".}
