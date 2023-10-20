type dep_struct* = object
  x*: uint32
  y*: float64

proc get_x*(dep_struct: ptr dep_struct): uint32 {.importc: "get_x".}
