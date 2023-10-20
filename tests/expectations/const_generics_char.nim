type TakeUntil_0* = object
  start*: pointer
  len*: uint
  point*: uint

proc until_nul*(start: pointer, len: uint): TakeUntil_0 {.importc: "until_nul".}
