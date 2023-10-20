type HasBitfields* = object
  foo*: uint64
  bar*: uint64

proc root*(a0: ptr HasBitfields): void {.importc: "root".}
