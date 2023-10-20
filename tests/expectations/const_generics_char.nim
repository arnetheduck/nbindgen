
type TakeUntil_10* = object
  xstart*: pointer
  xlen*: uint
  xpoint*: uint

proc until_nul*(start: pointer, len: uint): TakeUntil_10 {.importc: "until_nul".}
