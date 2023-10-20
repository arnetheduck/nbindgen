
type Color* = object
  xr*: uint8
  xg*: uint8
  xb*: uint8
  xa*: uint8

type Rect* = object
  xx*: float32
  xy*: float32
  xw*: float32
  xh*: float32

type DisplayItem_Tag* {.size: sizeof(uint8).} = enum
  Fill
  Image
  ClearScreen

type Fill_Body* = object
  x0*: DisplayItem_Tag
  x1*: Color

type Image_Body* = object
  xid*: DisplayItem_Tag
  xbounds*: Rect

type DisplayItem* = object
  case tag*: DisplayItem_Tag

  of Fill:
    fill*: Fill_Body
  of Image:
    image*: Image_Body
  else: discard

proc push_item*(item: DisplayItem): bool {.importc: "push_item".}
