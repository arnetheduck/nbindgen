type RustAlign4Struct* {.incompleteStruct.} = object

type RustAlign4Union* {.incompleteStruct.} = object

type RustPackedStruct* {.incompleteStruct.} = object

type RustPackedUnion* {.incompleteStruct.} = object

type UnsupportedAlign4Enum* {.incompleteStruct.} = object

type UnsupportedPacked4Struct* {.incompleteStruct.} = object

type UnsupportedPacked4Union* {.incompleteStruct.} = object

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

type PackedStruct* = object
  arg1*: uint
  arg2*: pointer

type Align1Union* {.union.} = object
  variant1*: uint
  variant2*: pointer

type Align4Union* {.union.} = object
  variant1*: uint
  variant2*: pointer

type Align16Union* {.union.} = object
  variant1*: uint
  variant2*: pointer

type PackedUnion* {.union.} = object
  variant1*: uint
  variant2*: pointer
