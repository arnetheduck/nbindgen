
type Option_1i32* {.incompleteStruct.} = object

type Result_1i32_2String* {.incompleteStruct.} = object

type Vec_1String* {.incompleteStruct.} = object

proc root*(a: ptr Vec_1String,
           b: ptr Option_1i32,
           c: ptr Result_1i32_2String): void {.importc: "root".}
