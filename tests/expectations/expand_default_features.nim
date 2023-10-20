
type Foo* = object


proc extra_debug_fn*(): void {.importc: "extra_debug_fn".}

proc root*(a: Foo): void {.importc: "root".}
