#if 0
''' '
#endif

#ifdef __cplusplus
template <typename T>
using Box = T*;
#endif

#if 0
' '''
#endif




type NotReprC_1_4i32* {.incompleteStruct.} = object

type Foo* = NotReprC_1_4i32

type MyStruct* = object
  xnumber*: pointer

proc root*(a: ptr Foo, with_box: ptr MyStruct): void {.importc: "root".}

proc drop_box*(x: pointer): void {.importc: "drop_box".}

proc drop_box_opt*(x: pointer): void {.importc: "drop_box_opt".}
