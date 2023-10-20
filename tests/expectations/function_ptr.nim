
type MyCallback* = proc(a: uint, b: uint): void

type MyOtherCallback* = proc(a: uint, lot: uint, ofx: uint, args: uint, and_then_some: uint): void

proc my_function*(a: MyCallback, b: MyOtherCallback): void {.importc: "my_function".}
