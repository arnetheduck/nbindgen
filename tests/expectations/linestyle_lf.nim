type Dummy* = object
  x*: int32
  y*: float32

proc root*(d: Dummy): void {.importc: "root".}
