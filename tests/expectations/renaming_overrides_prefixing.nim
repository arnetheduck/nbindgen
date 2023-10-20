
type StyleA* {.incompleteStruct.} = object

type B* = object
  xx*: int32
  xy*: float32

proc root*(a: ptr StyleA, b: B): void {.importc: "root".}
