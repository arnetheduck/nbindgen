type OpaquePackedStruct* {.incompleteStruct.} = object

type OpaquePackedUnion* {.incompleteStruct.} = object

type Align1Union* {.union.} = object
  variant1*: uint
  variant2*: pointer

type Align4Union* {.union.} = object
  variant1*: uint
  variant2*: pointer

type Align16Union* {.union.} = object
  variant1*: uint
  variant2*: pointer

type Align1Struct* = object
  arg1*: uint
  arg2*: pointer

type Align2Struct* = object
  arg1*: uint
  arg2*: pointer

type Align4Struct* = object
  arg1*: uint
  arg2*: pointer

type Align8Struct* = object
  arg1*: uint
  arg2*: pointer

type Align32Struct* = object
  arg1*: uint
  arg2*: pointer
