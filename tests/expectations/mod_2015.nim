const EXPORT_ME_TOO* = 42


type ExportMe* = object
  xval*: uint64

proc export_me*(val: ptr ExportMe): void {.importc: "export_me".}

proc from_really_nested_mod*(): void {.importc: "from_really_nested_mod".}
