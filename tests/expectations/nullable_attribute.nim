type Opaque* {.incompleteStruct.} = object

type References* = object
  a*: ptr Opaque
  b*: ptr Opaque
  c*: ptr Opaque
  d*: ptr Opaque

type Pointers_u64* = object
  a*: pointer
  b*: pointer
  c*: ptr Opaque
  d*: ptr pointer
  e*: ptr pointer
  f*: ptr ptr Opaque
  g*: pointer
  h*: pointer
  i*: ptr pointer
  j*: pointer
  k*: pointer

proc value_arg*(arg: References): void {.importc: "value_arg".}

proc mutltiple_args*(arg: pointer,
                     foo: ptr Pointers_u64,
                     d: ptr ptr Opaque): void {.importc: "mutltiple_args".}

proc ref_arg*(arg: ptr Pointers_u64): void {.importc: "ref_arg".}

proc mut_ref_arg*(arg: ptr Pointers_u64): void {.importc: "mut_ref_arg".}

proc optional_ref_arg*(arg: ptr Pointers_u64): void {.importc: "optional_ref_arg".}

proc optional_mut_ref_arg*(arg: ptr Pointers_u64): void {.importc: "optional_mut_ref_arg".}

proc nullable_const_ptr*(arg: ptr Pointers_u64): void {.importc: "nullable_const_ptr".}

proc nullable_mut_ptr*(arg: ptr Pointers_u64): void {.importc: "nullable_mut_ptr".}
