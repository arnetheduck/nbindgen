
type Foo* = object


proc extra_debug_fn*(): void {.importc: "extra_debug_fn".}

proc cbindgen*(): void {.importc: "cbindgen".}

proc root*(a: Foo): void {.importc: "root".}
