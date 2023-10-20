#if 0
''' '
#endif

#ifdef __cplusplus
template <typename T>
using Box = T*;
#endif

#if 0
' '''
#endif




type A* {.size: sizeof(uint64).} = enum
  a1
  a2
  a3
  a4

type B* {.size: sizeof(uint32).} = enum
  b1
  b2
  b3
  b4

type C* {.size: sizeof(uint16).} = enum
  c1
  c2
  c3
  c4

type D* {.size: sizeof(uint8).} = enum
  d1
  d2
  d3
  d4

type E* {.size: sizeof(uint).} = enum
  e1
  e2
  e3
  e4

type F* {.size: sizeof(int).} = enum
  f1
  f2
  f3
  f4

type L* = enum
  l1
  l2
  l3
  l4

type M* {.size: sizeof(int8).} = enum
  m1
  m2
  m3

type N* = enum
  n1
  n2
  n3
  n4

type O* {.size: sizeof(int8).} = enum
  o1
  o2
  o3
  o4

type J* {.incompleteStruct.} = object

type K* {.incompleteStruct.} = object

type Opaque* {.incompleteStruct.} = object

type G_Tag* {.size: sizeof(uint8).} = enum
  Foo
  Bar
  Baz

type Bar_Body* = object
  xx*: G_Tag
  xy*: int16

type G* = object
  case tag*: G_Tag

  of Foo:
    xfoo*: G_Tag
  of Bar:
    bar*: Bar_Body
  else: discard

type H_Tag* = enum
  H_Foo
  H_Bar
  H_Baz

type H_Bar_Body* = object
  xx*: uint8
  xy*: int16

type H* = object
  case tag*: H_Tag

  of H_Foo:
    xfoo*: int16
  of H_Bar:
    bar*: H_Bar_Body
  else: discard

type ExI_Tag* {.size: sizeof(uint8).} = enum
  ExI_Foo
  ExI_Bar
  ExI_Baz

type ExI_Bar_Body* = object
  xx*: uint8
  xy*: int16

type ExI* = object
  case tag*: ExI_Tag

  of ExI_Foo:
    xfoo*: int16
  of ExI_Bar:
    bar*: ExI_Bar_Body
  else: discard

type P_Tag* {.size: sizeof(uint8).} = enum
  P0
  P1

type P1_Body* = object
  x0*: uint8
  x1*: uint8
  x2*: uint8

type P* = object
  case tag*: P_Tag

  of P0:
    xp0*: uint8
  of P1:
    p1*: P1_Body

type Q_Tag* = enum
  Ok
  Err

type Q* = object
  case tag*: Q_Tag

  of Ok:
    xok*: pointer
  of Err:
    xerr*: uint32

type R_Tag* = enum
  IRFoo
  IRBar
  IRBaz

type IRBar_Body* = object
  xx*: uint8
  xy*: int16

type R* = object
  case tag*: R_Tag

  of IRFoo:
    xIRFoo*: int16
  of IRBar:
    IRBar*: IRBar_Body
  else: discard

proc root*(opaque: ptr Opaque,
           a: A,
           b: B,
           c: C,
           d: D,
           e: E,
           f: F,
           g: G,
           h: H,
           i: ExI,
           j: J,
           k: K,
           l: L,
           m: M,
           n: N,
           o: O,
           p: P,
           q: Q,
           r: R): void {.importc: "root".}

#if 0
''' '
#endif

#include <stddef.h>
#include "testing-helpers.h"
static_assert(offsetof(CBINDGEN_STRUCT(P), tag) == 0, "unexpected offset for tag");
static_assert(offsetof(CBINDGEN_STRUCT(P), p0) == 1, "unexpected offset for p0");
static_assert(offsetof(CBINDGEN_STRUCT(P), p0) == 1, "unexpected offset for p1");
static_assert(sizeof(CBINDGEN_STRUCT(P)) == 4, "unexpected size for P");

#if 0
' '''
#endif
