type PinTest* = object
  pinned_box*: pointer
  pinned_ref*: pointer

proc root*(s: pointer, p: PinTest): void {.importc: "root".}
