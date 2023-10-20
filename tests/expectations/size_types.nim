type UE* {.size: sizeof(uint).} = enum
  UV

type IE* {.size: sizeof(int).} = enum
  IV

type Usize* = uint

type Isize* = int

proc root*(a0: Usize, a1: Isize, a2: UE, a3: IE): void {.importc: "root".}
