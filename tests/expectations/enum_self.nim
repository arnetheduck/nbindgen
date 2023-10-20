
type Bar_Tag* {.size: sizeof(uint8).} = enum
  Min
  Max
  Other

type Bar* = object
  case tag*: Bar_Tag

  of Min:
    xmin*: Bar_Tag
  of Max:
    xmax*: Bar_Tag
  else: discard

proc root*(b: Bar): void {.importc: "root".}
