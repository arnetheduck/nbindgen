const FONT_WEIGHT_FRACTION_BITS* = 6


type FixedPoint_1FONT_WEIGHT_FRACTION_BITS* = object
  xvalue*: uint16

type FontWeightFixedPoint* = FixedPoint_1FONT_WEIGHT_FRACTION_BITS

type FontWeight* = object
  x0*: FontWeightFixedPoint
const FontWeight_NORMAL* = FontWeight()

proc root*(w: FontWeight): void {.importc: "root".}
