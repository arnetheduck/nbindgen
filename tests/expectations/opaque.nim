#if 0
''' '
#endif

#ifdef __cplusplus
// These could be added as opaque types I guess.
template <typename T>
struct BuildHasherDefault;

struct DefaultHasher;
#endif

#if 0
' '''
#endif




type HashMap_1i32_2i32_2BuildHasherDefault_1DefaultHasher* {.incompleteStruct.} = object

type Result_1Foo* {.incompleteStruct.} = object

## Fast hash map used internally.
type FastHashMap_1i32_2i32* = HashMap_1i32_2i32_2BuildHasherDefault_1DefaultHasher

type Foo* = FastHashMap_1i32_2i32

type Bar* = Result_1Foo

proc root*(a: ptr Foo, b: ptr Bar): void {.importc: "root".}
