
type TBar* {.incompleteStruct.} = object

type TFoo* = object


var NUMBER*: int32

var FOO*: TFoo

var BAR*: TBar

proc root*(): void {.importc: "root".}
