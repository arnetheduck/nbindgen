
type Opaque* {.incompleteStruct.} = object

type Normal* {.union.} = object
  x*: int32
  y*: float32

type NormalWithZST* {.union.} = object
  x*: int32
  y*: float32

proc root*(a: ptr Opaque, b: Normal, c: NormalWithZST): void {.importc: "root".}
