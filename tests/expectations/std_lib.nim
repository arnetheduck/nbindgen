type Option_i32* {.incompleteStruct.} = object

type Result_i32_String* {.incompleteStruct.} = object

type Vec_String* {.incompleteStruct.} = object

proc root*(a: ptr Vec_String, b: ptr Option_i32, c: ptr Result_i32_String): void {.importc: "root".}
