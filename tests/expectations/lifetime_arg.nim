type A* = object
  data*: pointer

type E_Tag* = enum
  V
  U

type E* = object
  case tag*: E_Tag

  of U:
    u*: pointer
  else: discard

proc root*(x_a: A, x_e: E): void {.importc: "root".}
