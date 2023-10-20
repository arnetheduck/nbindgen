#if 0
DEF PLATFORM_UNIX = 0
DEF PLATFORM_WIN = 0
DEF X11 = 0
DEF M_32 = 0
#endif




when (defined(PLATFORM_WIN) or defined(M_32)):
  type BarType* {.size: sizeof(uint32).} = enum
    A
    B
    C


when (defined(PLATFORM_UNIX) and defined(X11)):
  type FooType* {.size: sizeof(uint32).} = enum
    A
    B
    C


when (defined(PLATFORM_UNIX) and defined(X11)):
  type FooHandle* = object
    xty*: FooType
    xx*: int32
    xy*: float32


type C_Tag* {.size: sizeof(uint8).} = enum
  C1
  C2
  when defined(PLATFORM_WIN):
    C3

  when defined(PLATFORM_UNIX):
    C5


when defined(PLATFORM_UNIX):
  type C5_Body* = object
    xint*: C_Tag


type C* = object
  case tag*: C_Tag

  when defined(PLATFORM_UNIX):
    of when defined(PLATFORM_UNIX):
      C5
    :
      c5*: C5_Body

  else: discard

when (defined(PLATFORM_WIN) or defined(M_32)):
  type BarHandle* = object
    xty*: BarType
    xx*: int32
    xy*: float32


type ConditionalField* = object
  when defined(X11):
    xfield*: int32



  when (defined(PLATFORM_UNIX) and defined(X11)):
    proc root*(a: FooHandle, c: C): void {.importc: "root".}


  when (defined(PLATFORM_WIN) or defined(M_32)):
    proc root*(a: BarHandle, c: C): void {.importc: "root".}


  proc cond*(a: ConditionalField): void {.importc: "cond".}
