type NotReprC_RefCell_i32* {.incompleteStruct.} = object

type Foo* = NotReprC_RefCell_i32

type MyStruct* = object
  number*: int32

proc root*(a: ptr Foo, with_cell: ptr MyStruct): void {.importc: "root".}
