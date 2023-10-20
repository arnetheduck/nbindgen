type OpaqueAlign16Union* {.incompleteStruct.} = object

type OpaqueAlign1Struct* {.incompleteStruct.} = object

type OpaqueAlign1Union* {.incompleteStruct.} = object

type OpaqueAlign2Struct* {.incompleteStruct.} = object

type OpaqueAlign32Struct* {.incompleteStruct.} = object

type OpaqueAlign4Struct* {.incompleteStruct.} = object

type OpaqueAlign4Union* {.incompleteStruct.} = object

type OpaqueAlign8Struct* {.incompleteStruct.} = object

type PackedStruct* = object
  arg1*: uint
  arg2*: pointer

type PackedUnion* {.union.} = object
  variant1*: uint
  variant2*: pointer
