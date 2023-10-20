
type Bar* = object
  xa*: int32

type Foo* = object
  xa*: int32
  xb*: uint32
  xbar*: PREFIXBar

const PREFIXVAL* = PREFIXFoo()

proc root*(x: PREFIXFoo): void {.importc: "root".}
