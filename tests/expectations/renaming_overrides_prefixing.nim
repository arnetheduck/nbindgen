type StyleA* {.incompleteStruct.} = object

type B* = object
  x*: int32
  y*: float32

proc root*(a: ptr StyleA, b: B): void {.importc: "root".}
