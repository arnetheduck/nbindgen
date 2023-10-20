
type MyCLikeEnum* = enum
  Foo1
  Bar1
  Baz1

type MyCLikeEnum_Prepended* = enum
  Foo1_Prepended
  Bar1_Prepended
  Baz1_Prepended

type MyFancyStruct* = object
  xi*: int32
#ifdef __cplusplus
    inline void foo();
#endif

type MyFancyEnum_Tag* = enum
  Foo
  Bar
  Baz

type MyFancyEnum* = object
  case tag*: MyFancyEnum_Tag

  of Bar:
    xbar*: int32
  of Baz:
    xbaz*: int32
  else: discard
#ifdef __cplusplus
    inline void wohoo();
#endif

type MyUnion* {.union.} = object
  f*: float32
  u*: uint32
  int32_t extra_member;

type MyFancyStruct_Prepended* = object
#ifdef __cplusplus
    inline void prepended_wohoo();
#endif
  xi*: int32

type MyFancyEnum_Prepended_Tag* = enum
  Foo_Prepended
  Bar_Prepended
  Baz_Prepended

type MyFancyEnum_Prepended* = object
#ifdef __cplusplus
    inline void wohoo();
#endif
  case tag*: MyFancyEnum_Prepended_Tag

  of Bar_Prepended:
    xbar_prepended*: int32
  of Baz_Prepended:
    xbaz_prepended*: int32
  else: discard

type MyUnion_Prepended* {.union.}    int32_t extra_member;
 = object
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
