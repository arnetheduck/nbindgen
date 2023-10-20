const BYTES* = @[97, 98, 99]

const SLICE* = @[110, 111, 116, 32, 110, 117, 108, 108, 0, 116, 101, 114, 109, 105, 110, 97, 116, 101, 100]

const BINARY* = @[0, 255, 16, 127]

const EMPTY* = @[]

## A documented byte-string constant.
const DOCUMENTED* = @[100, 111, 99]

proc root*(): void {.importc: "root".}
