
type TBar* {.incompleteStruct.} = object

type TFoo* = object
  xa*: int32
  xb*: uint32

const BAR* = TFoo()



const Foo_FOO* = TFoo()

const Foo_FOO2* = TFoo()





proc root*(x: TFoo, bar: TBar): void {.importc: "root".}
