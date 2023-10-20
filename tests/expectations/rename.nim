const C_H* = 10


type C_E* {.size: sizeof(uint8).} = enum
  x
  y

type C_A* {.incompleteStruct.} = object

type C_C* {.incompleteStruct.} = object

type B* = object
  xx*: int32
  xy*: float32

type C_D* {.union.} = object
  x*: int32
  y*: float32

type C_F* = C_A

const C_I* = cast[int](cast[ptr C_F](10))

var G*: int32

proc root*(a: ptr C_A, b: C_AwesomeB, c: C_C, d: C_D, e: C_E, f: C_F): void {.importc: "root".}
