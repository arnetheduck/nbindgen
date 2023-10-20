type Foo* = object
  x*: int32

type RenamedTy* = object
  y*: uint64

when not (defined(DEFINE_FREEBSD)):
  type NoExternTy* = object
    field*: uint8


when not (defined(DEFINE_FREEBSD)):
  type ContainsNoExternTy* = object
    field*: NoExternTy


when defined(DEFINE_FREEBSD):
  type ContainsNoExternTy* = object
    field*: uint64


proc root*(a: Foo): void {.importc: "root".}

proc renamed_func*(a: RenamedTy): void {.importc: "renamed_func".}

proc no_extern_func*(a: ContainsNoExternTy): void {.importc: "no_extern_func".}
