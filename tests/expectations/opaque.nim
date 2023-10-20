type HashMap_i32_i32_BuildHasherDefault_DefaultHasher* {.incompleteStruct.} = object

type Result_Foo* {.incompleteStruct.} = object

## Fast hash map used internally.
type FastHashMap_i32_i32* = HashMap_i32_i32_BuildHasherDefault_DefaultHasher

type Foo* = FastHashMap_i32_i32

type Bar* = Result_Foo

proc root*(a: ptr Foo, b: ptr Bar): void {.importc: "root".}
