var FIRST*: uint32

var RENAMED*: uint32

proc first*(): void {.importc: "first".}

proc renamed*(): void {.importc: "renamed".}
