#define CBINDGEN_PACKED        __attribute__ ((packed))
#define CBINDGEN_ALIGNED(n)    __attribute__ ((aligned(n)))




type OpaqueAlign16Union* {.incompleteStruct.} = object

type OpaqueAlign1Struct* {.incompleteStruct.} = object

type OpaqueAlign1Union* {.incompleteStruct.} = object

type OpaqueAlign2Struct* {.incompleteStruct.} = object

type OpaqueAlign32Struct* {.incompleteStruct.} = object

type OpaqueAlign4Struct* {.incompleteStruct.} = object

type OpaqueAlign4Union* {.incompleteStruct.} = object

type OpaqueAlign8Struct* {.incompleteStruct.} = object

type PackedStruct* = object
  xarg1*: uint
  xarg2*: pointer

type PackedUnion* {.union.} = object
  variant1*: uint
  variant2*: pointer
