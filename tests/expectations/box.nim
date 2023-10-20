type NotReprC_i32* {.incompleteStruct.} = object

type Foo* = NotReprC_i32

type MyStruct* = object
  number*: pointer

proc root*(a: ptr Foo, with_box: ptr MyStruct): void {.importc: "root".}

proc drop_box*(x: pointer): void {.importc: "drop_box".}

proc drop_box_opt*(x: pointer): void {.importc: "drop_box_opt".}
