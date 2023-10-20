#if 0
''' '
#endif

#ifdef __cplusplus
template <typename T>
using MaybeUninit = T;
#endif

#if 0
' '''
#endif




type NotReprC_1_5i32* {.incompleteStruct.} = object

type Foo* = NotReprC_1_5i32

type MyStruct* = object
  xnumber*: pointer

proc root*(a: ptr Foo, with_maybe_uninit: ptr MyStruct): void {.importc: "root".}
