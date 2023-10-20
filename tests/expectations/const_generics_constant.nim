const FONT_WEIGHT_FRACTION_BITS* = 6

type FixedPoint_FONT_WEIGHT_FRACTION_BITS* = object
  value*: uint16

type FontWeightFixedPoint* = FixedPoint_FONT_WEIGHT_FRACTION_BITS

type FontWeight* = object
  x_0*: FontWeightFixedPoint

proc root*(w: FontWeight): void {.importc: "root".}
