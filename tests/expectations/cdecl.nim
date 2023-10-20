
type A* = proc(): void

type B* = proc(): void

type C* = proc(a0: int32, a1: int32): bool

type D* = proc(a0: int32): (proc(a0: float32): bool)

type E* = proc(): ptr int32

type F* = pointer

type G* = ptr pointer

type H* = ptr pointer

type I* = ptr int32

type J* = proc(a0: float32): ptr float64

type K* = int32

type L* = pointer

type M* = proc(a0: int32, a1: int32): bool

type N* = proc(a0: int32, a1: int32): void

type P* = proc(named1st: int32, a1: bool, named3rd: bool, wild: int32): void

type Q* = proc(v: pointer): void

proc O*(): (proc(): void) {.importc: "O".}

proc root*(a: A,
           b: B,
           c: C,
           d: D,
           e: E,
           f: F,
           g: G,
           h: H,
           i: I,
           j: J,
           k: K,
           l: L,
           m: M,
           n: N,
           p: P,
           q: Q): void {.importc: "root".}
