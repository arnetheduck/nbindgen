#if 0
DEF DEFINE_FREEBSD = 0
#endif




type Foo* = object
  xx*: int32

type RenamedTy* = object
  xy*: uint64

when not (defined(DEFINE_FREEBSD)):
  type NoExternTy* = object
    xfield*: uint8


when not (defined(DEFINE_FREEBSD)):
  type ContainsNoExternTy* = object
    xfield*: NoExternTy


when defined(DEFINE_FREEBSD):
  type ContainsNoExternTy* = object
    xfield*: uint64


proc root*(a: Foo): void {.importc: "root".}

proc renamed_func*(a: RenamedTy): void {.importc: "renamed_func".}

proc no_extern_func*(a: ContainsNoExternTy): void {.importc: "no_extern_func".}
