type FillRule* {.size: sizeof(uint8).} = enum
  Nonzero
  Evenodd

type Style* = object
  rule*: FillRule

const DEFAULT_FILL_RULE* = Nonzero

const ALL_FILL_RULES* = @[Nonzero, Evenodd]

proc root*(rule: FillRule, style: Style): void {.importc: "root".}
