const EXPORT_ME_TOO* = 42


type ExportMe* = object
  xval*: uint64

proc export_me*(val: ptr ExportMe): void {.importc: "export_me".}
