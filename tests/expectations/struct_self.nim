
type Foo_1Bar* = object
  xsomething*: pointer

type Bar* = object
  xsomething*: int32
  xsubexpressions*: Foo_1Bar

proc root*(b: Bar): void {.importc: "root".}
