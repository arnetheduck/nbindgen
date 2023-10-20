type TBar* {.incompleteStruct.} = object

type TFoo* = object
  a*: int32
  b*: uint32

const BAR* = TFoo(a: 42, b: 1337)



const Foo_FOO* = TFoo(a: 42, b: 47)

const Foo_FOO2* = TFoo(a: 42, b: 47)





proc root*(x: TFoo, bar: TBar): void {.importc: "root".}
