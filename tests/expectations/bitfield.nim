
type HasBitfields* = object
  xfoo*: uint64: 8
  xbar*: uint64: 56

proc root*(a0: ptr HasBitfields): void {.importc: "root".}
