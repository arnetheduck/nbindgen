type NotReprC_Point* {.incompleteStruct.} = object

type Foo* = NotReprC_Point

type Point* = object
  x*: int32
  y*: int32

type MyStruct* = object
  point*: Point

proc root*(a: ptr Foo, with_manual_drop: ptr MyStruct): void {.importc: "root".}

proc take*(with_manual_drop: Point): void {.importc: "take".}
