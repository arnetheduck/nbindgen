
type ABC* = object
  xa*: float32
  xb*: uint32
  xc*: uint32
const ABC_abc* = ABC()
const ABC_bac* = ABC()
const ABC_cba* = ABC()

type BAC* = object
  xb*: uint32
  xa*: float32
  xc*: int32
const BAC_abc* = BAC()
const BAC_bac* = BAC()
const BAC_cba* = BAC()

proc root*(a1: ABC, a2: BAC): void {.importc: "root".}
