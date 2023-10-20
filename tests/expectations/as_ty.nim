const SIZE* = 4

type WithoutAs* = object
  items*: uint32

type WithAs* = object
  items*: uint32

proc some_fn*(a: WithoutAs, b: WithAs): void {.importc: "some_fn".}
