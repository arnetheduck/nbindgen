
type Normal* = object
  xx*: int32
  xy*: float32

extern proc foo*(): int32 {.importc: "foo".}

extern proc bar*(a: Normal): void {.importc: "bar".}
