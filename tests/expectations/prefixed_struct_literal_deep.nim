type PREFIXBar* = object
  a*: int32

type PREFIXFoo* = object
  a*: int32
  b*: uint32
  bar*: PREFIXBar

const PREFIXVAL* = PREFIXFoo(a: 42, b: 1337, bar: PREFIXBar(a: 323))

proc root*(x: PREFIXFoo): void {.importc: "root".}
