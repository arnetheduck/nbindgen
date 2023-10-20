#define MUST_USE_FUNC __attribute__((warn_unused_result))
#define MUST_USE_STRUCT __attribute__((warn_unused))
#define MUST_USE_ENUM /* nothing */




type MaybeOwnedPtr_1i32_Tag* {.size: sizeof(uint8).} = enum
  Owned_1i32
  None_1i32

type MaybeOwnedPtr_1i32* = object
  case tag*: MaybeOwnedPtr_1i32_Tag

  of Owned_1i32:
    xowned*: pointer
  else: discard

type MUST_USE_STRUCT OwnedPtr_1i32* = object
  xptr*: pointer

MUST_USE_FUNC
MUST_USE_FUNC
proc maybe_consume*(input: OwnedPtr_1i32): MaybeOwnedPtr_1i32 {.importc: "maybe_consume".}
