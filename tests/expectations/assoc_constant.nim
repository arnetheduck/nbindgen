
type Foo* = object

const Foo_GA* = 10
const Foo_ZO* = 3.14

proc root*(x: Foo): void {.importc: "root".}
