type NotReprC_i32* {.incompleteStruct.} = object

type Foo* = NotReprC_i32

type MyStruct* = object
  number*: pointer

proc root*(a: ptr Foo, with_maybe_uninit: ptr MyStruct): void {.importc: "root".}
