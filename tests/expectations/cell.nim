
type NotReprC_1RefCell_1i32* {.incompleteStruct.} = object

type Foo* = NotReprC_1RefCell_1i32

type MyStruct* = object
  xnumber*: int32

proc root*(a: ptr Foo, with_cell: ptr MyStruct): void {.importc: "root".}
