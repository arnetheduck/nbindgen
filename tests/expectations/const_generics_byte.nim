type Parser_40_41* = object
  buf*: pointer
  len*: uint

type Parser_123_125* = object
  buf*: pointer
  len*: uint

proc init_parens_parser*(p: ptr Parser_40_41,
                         buf: pointer,
                         len: uint): void {.importc: "init_parens_parser".}

proc destroy_parens_parser*(p: ptr Parser_40_41): void {.importc: "destroy_parens_parser".}

proc init_braces_parser*(p: ptr Parser_123_125,
                         buf: pointer,
                         len: uint): void {.importc: "init_braces_parser".}
