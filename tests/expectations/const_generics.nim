const TITLE_SIZE* = 80


type CArrayString_1TITLE_SIZE* = int8

type CArrayString_140* = int8

type Book* = object
  xtitle*: CArrayString_1TITLE_SIZE
  xauthor*: CArrayString_140

proc root*(a: ptr Book): void {.importc: "root".}
