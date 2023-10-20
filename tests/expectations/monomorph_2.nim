type A* {.incompleteStruct.} = object

type B* {.incompleteStruct.} = object

type List_A* = object
  members*: ptr A
  count*: uint

type List_B* = object
  members*: ptr B
  count*: uint

proc foo*(a: List_A): void {.importc: "foo".}

proc bar*(b: List_B): void {.importc: "bar".}
