
type Dummy* = object
  xx*: int32
  xy*: float32

proc root*(d: Dummy): void {.importc: "root".}
