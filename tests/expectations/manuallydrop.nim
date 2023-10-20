#if 0
''' '
#endif

#ifdef __cplusplus
template <typename T>
using ManuallyDrop = T;
#endif

#if 0
' '''
#endif




type NotReprC_1Point* {.incompleteStruct.} = object

type Foo* = NotReprC_1Point

type Point* = object
  xx*: int32
  xy*: int32

type MyStruct* = object
  xpoint*: Point

proc root*(a: ptr Foo, with_manual_drop: ptr MyStruct): void {.importc: "root".}

proc take*(with_manual_drop: Point): void {.importc: "take".}
