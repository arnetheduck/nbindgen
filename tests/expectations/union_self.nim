type Foo_Bar* = object
  something*: pointer

type Bar* {.union.} = object
  something*: int32
  subexpressions*: Foo_Bar

proc root*(b: Bar): void {.importc: "root".}
