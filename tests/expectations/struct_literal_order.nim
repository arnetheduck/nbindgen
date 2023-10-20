type ABC* = object
  a*: float32
  b*: uint32
  c*: uint32

type BAC* = object
  b*: uint32
  a*: float32
  c*: int32

proc root*(a1: ABC, a2: BAC): void {.importc: "root".}
