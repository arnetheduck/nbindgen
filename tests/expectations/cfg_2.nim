#if 0
DEF DEFINED = 1
DEF NOT_DEFINED = 0
#endif



when defined(NOT_DEFINED):
  const DEFAULT_X* = 8


when defined(DEFINED):
  const DEFAULT_X* = 42



when (defined(NOT_DEFINED) or defined(DEFINED)):
  type Foo* = object
    xx*: int32


when defined(NOT_DEFINED):
  type Bar* = object
    xy*: Foo


when defined(DEFINED):
  type Bar* = object
    xz*: Foo


type Root* = object
  xw*: Bar

proc root*(a: Root): void {.importc: "root".}
