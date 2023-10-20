const EXPORT_ME_TOO* = 42

type ExportMe* = object
  val*: uint64

type ExportMe2* = object
  val*: uint64

proc export_me*(val: ptr ExportMe): void {.importc: "export_me".}

proc export_me_2*(a0: ptr ExportMe2): void {.importc: "export_me_2".}

proc from_really_nested_mod*(): void {.importc: "from_really_nested_mod".}
