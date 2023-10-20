
type dep_struct* = object
  xx*: uint32
  xy*: float64

proc get_x*(dep_struct: ptr dep_struct): uint32 {.importc: "get_x".}
