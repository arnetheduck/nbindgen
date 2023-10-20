
type Opaque* {.incompleteStruct.} = object

type Normal* = object
  xx*: int32
  xy*: float32

type NormalWithZST* = object
  xx*: int32
  xy*: float32

type TupleRenamed* = object
  m0*: int32
  m1*: float32

type TupleNamed* = object
  x*: int32
  y*: float32

proc root*(a: ptr Opaque,
           b: Normal,
           c: NormalWithZST,
           d: TupleRenamed,
           e: TupleNamed): void {.importc: "root".}
