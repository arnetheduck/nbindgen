
type Parser_140_241* = object
  xbuf*: pointer
  xlen*: uint

type Parser_1123_2125* = object
  xbuf*: pointer
  xlen*: uint

proc init_parens_parser*(p: ptr Parser_140_241,
                         buf: pointer,
                         len: uint): void {.importc: "init_parens_parser".}

proc destroy_parens_parser*(p: ptr Parser_140_241): void {.importc: "destroy_parens_parser".}

proc init_braces_parser*(p: ptr Parser_1123_2125,
                         buf: pointer,
                         len: uint): void {.importc: "init_braces_parser".}
