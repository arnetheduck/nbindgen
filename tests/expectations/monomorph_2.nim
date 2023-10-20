
type A* {.incompleteStruct.} = object

type B* {.incompleteStruct.} = object

type List_1A* = object
  xmembers*: ptr A
  xcount*: uint

type List_1B* = object
  xmembers*: ptr B
  xcount*: uint

proc foo*(a: List_1A): void {.importc: "foo".}

proc bar*(b: List_1B): void {.importc: "bar".}
