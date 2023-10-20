type Foo_Bar* = object
  something*: pointer

type Bar_Tag* {.size: sizeof(uint8).} = enum
  Min
  Max
  Other

type Bar* = object
  case tag*: Bar_Tag

  of Min:
    min_tag*: Bar_Tag
    min*: Foo_Bar
  of Max:
    max_tag*: Bar_Tag
    max*: Foo_Bar
  else: discard

proc root*(b: Bar): void {.importc: "root".}
