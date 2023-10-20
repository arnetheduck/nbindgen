type Opaque* {.incompleteStruct.} = object

type Foo_u64* = object
  a*: pointer
  b*: pointer
  c*: ptr Opaque
  d*: ptr pointer
  e*: ptr pointer
  f*: ptr ptr Opaque
  g*: pointer
  h*: pointer
  i*: ptr pointer

proc root*(arg: pointer, foo: ptr Foo_u64, d: ptr ptr Opaque): void {.importc: "root".}
