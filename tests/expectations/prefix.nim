const PREFIX_LEN* = 22

const PREFIX_X* = (22 shl 22)

const PREFIX_Y* = (PREFIX_X + PREFIX_X)

type PREFIX_NamedLenArray* = int32

type PREFIX_ValuedLenArray* = int32

type PREFIX_AbsoluteFontWeight_Tag* {.size: sizeof(uint8).} = enum
  Weight
  Normal
  Bold

type PREFIX_AbsoluteFontWeight* = object
  case tag*: PREFIX_AbsoluteFontWeight_Tag

  of Weight:
    weight_tag*: PREFIX_AbsoluteFontWeight_Tag
    weight*: float32
  else: discard

proc root*(x: PREFIX_NamedLenArray,
           y: PREFIX_ValuedLenArray,
           z: PREFIX_AbsoluteFontWeight): void {.importc: "root".}
