
type Opaque* {.incompleteStruct.} = object

type Option_1_4Opaque* {.incompleteStruct.} = object

type Foo* = object
  xx*: ptr Opaque
  xy*: ptr Opaque
  xz*: proc(): void
  xzz*: proc(): ptr void

type Bar* {.union.} = object
  x*: ptr Opaque
  y*: ptr Opaque
  z*: proc(): void
  zz*: proc(): ptr void

proc root*(a: ptr Opaque,
           b: ptr Opaque,
           c: Foo,
           d: Bar,
           e: ptr Option_1_4Opaque,
           f: proc(a0: ptr Opaque): void): void {.importc: "root".}
