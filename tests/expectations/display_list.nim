type Rect* = object
  x*: float32
  y*: float32
  w*: float32
  h*: float32

type Color* = object
  r*: uint8
  g*: uint8
  b*: uint8
  a*: uint8

type DisplayItem_Tag* {.size: sizeof(uint8).} = enum
  Fill
  Image
  ClearScreen

type Fill_Body* = object
  tag*: DisplayItem_Tag
  x_0*: Rect
  x_1*: Color

type Image_Body* = object
  tag*: DisplayItem_Tag
  id*: uint32
  bounds*: Rect

type DisplayItem* = object
  case tag*: DisplayItem_Tag

  of Fill:
    fill*: Fill_Body
  of Image:
    image*: Image_Body
  else: discard

proc push_item*(item: DisplayItem): bool {.importc: "push_item".}
