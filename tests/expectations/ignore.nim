const NO_IGNORE_CONST* = 0

const NoIgnoreStructWithImpl_NO_IGNORE_INNER_CONST* = 0

proc no_ignore_root*(): void {.importc: "no_ignore_root".}

proc no_ignore_associated_method*(): void {.importc: "no_ignore_associated_method".}
