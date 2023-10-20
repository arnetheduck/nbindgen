#if 0
''' '
#endif

#ifdef __cplusplus
template <typename T>
using Pin = T;
template <typename T>
using Box = T*;
#endif

#if 0
' '''
#endif




type PinTest* = object
  xpinned_box*: pointer
  xpinned_ref*: pointer

proc root*(s: pointer, p: PinTest): void {.importc: "root".}
