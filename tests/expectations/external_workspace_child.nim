
type ExtType* = object
  data: uint32

proc consume_ext*(x_ext: ExtType) {.importc: "consume_ext".}
