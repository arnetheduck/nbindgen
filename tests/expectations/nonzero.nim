type Option_i64* {.incompleteStruct.} = object

type NonZeroAliases* = object
  a*: uint8
  b*: uint16
  c*: uint32
  d*: uint64
  e*: int8
  f*: int16
  g*: int32
  h*: int64
  i*: int64
  j*: ptr Option_i64

type NonZeroGenerics* = object
  a*: uint8
  b*: uint16
  c*: uint32
  d*: uint64
  e*: int8
  f*: int16
  g*: int32
  h*: int64
  i*: int64
  j*: ptr Option_i64

proc root_nonzero_aliases*(test: NonZeroAliases,
                           a: uint8,
                           b: uint16,
                           c: uint32,
                           d: uint64,
                           e: int8,
                           f: int16,
                           g: int32,
                           h: int64,
                           i: int64,
                           j: ptr Option_i64): void {.importc: "root_nonzero_aliases".}

proc root_nonzero_generics*(test: NonZeroGenerics,
                            a: uint8,
                            b: uint16,
                            c: uint32,
                            d: uint64,
                            e: int8,
                            f: int16,
                            g: int32,
                            h: int64,
                            i: int64,
                            j: ptr Option_i64): void {.importc: "root_nonzero_generics".}
