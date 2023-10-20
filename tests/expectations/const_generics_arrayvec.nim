
type ArrayVec_1_4u8_2100* = object
  xxs*: pointer
  xlen*: uint32

proc push*(v: ptr ArrayVec_1_4u8_2100, elem: pointer): int32 {.importc: "push".}
