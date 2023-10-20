const C_STRING* = "winner"

const BYTES* = @[97, 98, 99]

const ARRAY* = @["first", "second"]

proc root*(): void {.importc: "root".}
