type MyCLikeEnum* = enum
  Foo1
  Bar1
  Baz1

type MyCLikeEnum_Prepended* = enum
  Foo1_Prepended
  Bar1_Prepended
  Baz1_Prepended

type MyFancyStruct* = object
  i*: int32

type MyFancyEnum_Tag* = enum
  Foo
  Bar
  Baz

type MyFancyEnum* = object
  case tag*: MyFancyEnum_Tag

  of Bar:
    bar*: int32
  of Baz:
    baz*: int32
  else: discard

type MyUnion* {.union.} = object
  f*: float32
  u*: uint32

type MyFancyStruct_Prepended* = object
  i*: int32

type MyFancyEnum_Prepended_Tag* = enum
  Foo_Prepended
  Bar_Prepended
  Baz_Prepended

type MyFancyEnum_Prepended* = object
  case tag*: MyFancyEnum_Prepended_Tag

  of Bar_Prepended:
    bar_prepended*: int32
  of Baz_Prepended:
    baz_prepended*: int32
  else: discard

type MyUnion_Prepended* {.union.} = object
  f*: float32
  u*: uint32

proc root*(s: MyFancyStruct,
           e: MyFancyEnum,
           c: MyCLikeEnum,
           u: MyUnion,
           sp: MyFancyStruct_Prepended,
           ep: MyFancyEnum_Prepended,
           cp: MyCLikeEnum_Prepended,
           up: MyUnion_Prepended): void {.importc: "root".}
