
type Opaque* {.incompleteStruct.} = object

type Foo_1u64* = object
  xa*: pointer
  xb*: pointer
  xc*: ptr Opaque
  xd*: ptr pointer
  xe*: ptr pointer
  xf*: ptr ptr Opaque
  xg*: pointer
  xh*: pointer
  xi*: ptr pointer

proc root*(arg: pointer, foo: ptr Foo_1u64, d: ptr ptr Opaque): void {.importc: "root".}
