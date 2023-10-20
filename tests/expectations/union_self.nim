
type Foo_1Bar* = object
  xsomething*: pointer

type Bar* {.union.} = object
  something*: int32
  subexpressions*: Foo_1Bar

proc root*(b: Bar): void {.importc: "root".}
