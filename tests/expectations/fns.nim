
type Fns* = object
  xnoArgs*: proc(): void
  xanonymousArg*: proc(a0: int32): void
  xreturnsNumber*: proc(): int32
  xnamedArgs*: proc(first: int32, snd: int16): int8
  xnamedArgsWildcards*: proc(wild: int32, named: int16, wild1: int64): int8

proc root*(x_fns: Fns): void {.importc: "root".}

proc no_return*(): void {.importc: "no_return".}
