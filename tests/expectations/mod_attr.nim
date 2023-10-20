#if 0
DEF FOO = 0
DEF BAR = 0
#endif



when defined(FOO):
  const FOO* = 1


when defined(BAR):
  const BAR* = 2



when defined(FOO):
  type Foo* = object



when defined(BAR):
  type Bar* = object



when defined(FOO):
  proc foo*(foo: ptr Foo): void {.importc: "foo".}


when defined(BAR):
  proc bar*(bar: ptr Bar): void {.importc: "bar".}

