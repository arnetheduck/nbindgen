#define CBINDGEN_PACKED     __attribute__ ((packed))
#define CBINDGEN_ALIGNED(n) __attribute__ ((aligned(n)))




type RustAlign4Struct* {.incompleteStruct.} = object

type RustAlign4Union* {.incompleteStruct.} = object

type RustPackedStruct* {.incompleteStruct.} = object

type RustPackedUnion* {.incompleteStruct.} = object

type UnsupportedAlign4Enum* {.incompleteStruct.} = object

type UnsupportedPacked4Struct* {.incompleteStruct.} = object

type UnsupportedPacked4Union* {.incompleteStruct.} = object

type Align1Struct* = object
  xarg1*: uint
  xarg2*: pointer

type Align2Struct* = object
  xarg1*: uint
  xarg2*: pointer

type Align4Struct* = object
  xarg1*: uint
  xarg2*: pointer

type Align8Struct* = object
  xarg1*: uint
  xarg2*: pointer

type Align32Struct* = object
  xarg1*: uint
  xarg2*: pointer

type PackedStruct* = object
  xarg1*: uint
  xarg2*: pointer

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
