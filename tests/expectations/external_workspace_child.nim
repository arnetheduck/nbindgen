type ExtType* = object
  data*: uint32

proc consume_ext*(x_ext: ExtType): void {.importc: "consume_ext".}
