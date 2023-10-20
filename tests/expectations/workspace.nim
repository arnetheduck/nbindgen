const EXT_CONST* = 0


type ExtType* = object
  xdata*: uint32

proc consume_ext*(x_ext: ExtType): void {.importc: "consume_ext".}
