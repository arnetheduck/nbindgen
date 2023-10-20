#ifdef __clang__
#define CBINDGEN_NONNULL _Nonnull
#else
#define CBINDGEN_NONNULL
#endif




type Opaque* {.incompleteStruct.} = object

type References* = object
  xa*: ptr Opaque
  xb*: ptr Opaque
  xc*: ptr Opaque
  xd*: ptr Opaque

type Pointers_1u64* = object
  xa*: pointer
  xb*: pointer
  xc*: ptr Opaque
  xd*: ptr pointer
  xe*: ptr pointer
  xf*: ptr ptr Opaque
  xg*: pointer
  xh*: pointer
  xi*: ptr pointer
  xj*: pointer
  xk*: pointer

proc value_arg*(arg: References): void {.importc: "value_arg".}

proc mutltiple_args*(arg: pointer,
                     foo: ptr Pointers_1u64,
                     d: ptr ptr Opaque): void {.importc: "mutltiple_args".}

proc ref_arg*(arg: ptr Pointers_1u64): void {.importc: "ref_arg".}

proc mut_ref_arg*(arg: ptr Pointers_1u64): void {.importc: "mut_ref_arg".}

proc optional_ref_arg*(arg: ptr Pointers_1u64): void {.importc: "optional_ref_arg".}

proc optional_mut_ref_arg*(arg: ptr Pointers_1u64): void {.importc: "optional_mut_ref_arg".}

proc nullable_const_ptr*(arg: ptr Pointers_1u64): void {.importc: "nullable_const_ptr".}

proc nullable_mut_ptr*(arg: ptr Pointers_1u64): void {.importc: "nullable_mut_ptr".}
