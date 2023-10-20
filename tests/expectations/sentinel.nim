
type A* {.size: sizeof(uint8).} = enum
  A_A1
  A_A2
  A_A3
  ## Must be last for serialization purposes
  A_Sentinel

type B* {.size: sizeof(uint8).} = enum
  B_B1
  B_B2
  B_B3
  ## Must be last for serialization purposes
  B_Sentinel

type C_Tag* {.size: sizeof(uint8).} = enum
  C_C1
  C_C2
  C_C3
  ## Must be last for serialization purposes
  C_Sentinel

type C_C1_Body* = object
  xa*: C_Tag

type C_C2_Body* = object
  xb*: C_Tag

type C* = object
  case tag*: C_Tag

  of C_C1:
    c1*: C_C1_Body
  of C_C2:
    c2*: C_C2_Body
  else: discard

proc root*(a: A, b: B, c: C): void {.importc: "root".}
