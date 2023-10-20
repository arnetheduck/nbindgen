const FOURTY_FOUR* = 4


type E* {.size: sizeof(int8).} = enum
  A
  B
  C
  D
  F
  G
  H

proc root*(a0: ptr E): void {.importc: "root".}
