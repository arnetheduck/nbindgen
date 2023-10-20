const TITLE_SIZE* = 80

type CArrayString_TITLE_SIZE* = int8

type CArrayString_40* = int8

type Book* = object
  title*: CArrayString_TITLE_SIZE
  author*: CArrayString_40

proc root*(a: ptr Book): void {.importc: "root".}
