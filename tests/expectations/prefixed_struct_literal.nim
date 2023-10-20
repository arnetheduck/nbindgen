
type Foo* = object
  xa*: int32
  xb*: uint32
const Foo_FOO* = PREFIXFoo()

const PREFIXBAR* = PREFIXFoo()

proc root*(x: PREFIXFoo): void {.importc: "root".}
