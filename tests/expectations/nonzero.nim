#if 0
''' '
#endif

#ifdef __cplusplus
struct NonZeroI64;
#endif

#if 0
' '''
#endif




type Option_1i64* {.incompleteStruct.} = object

type NonZeroTest* = object
  xa*: uint8
  xb*: uint16
  xc*: uint32
  xd*: uint64
  xe*: int8
  xf*: int16
  xg*: int32
  xh*: int64
  xi*: int64
  xj*: ptr Option_1i64

proc root*(test: NonZeroTest,
           a: uint8,
           b: uint16,
           c: uint32,
           d: uint64,
           e: int8,
           f: int16,
           g: int32,
           h: int64,
           i: int64,
           j: ptr Option_1i64): void {.importc: "root".}
