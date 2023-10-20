type ArrayVec_u8_100* = object
  xs*: pointer
  len*: uint32

proc push*(v: ptr ArrayVec_u8_100, elem: pointer): int32 {.importc: "push".}
