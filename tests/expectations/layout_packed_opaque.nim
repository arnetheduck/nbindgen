#define CBINDGEN_PACKED        __attribute__ ((packed))
#define CBINDGEN_ALIGNED(n)    __attribute__ ((aligned(n)))




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
