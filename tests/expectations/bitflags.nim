
## Constants shared by multiple CSS Box Alignment properties
#
# These constants match Gecko's `NS_STYLE_ALIGN_*` constants.
type AlignFlags* = object
  xbits*: uint8
const AlignFlags_AUTO* = AlignFlags()
const AlignFlags_NORMAL* = AlignFlags()
const AlignFlags_START* = AlignFlags()
const AlignFlags_END* = AlignFlags()
const AlignFlags_ALIAS* = AlignFlags()
const AlignFlags_FLEX_START* = AlignFlags()
const AlignFlags_MIXED* = AlignFlags()
const AlignFlags_MIXED_SELF* = AlignFlags()

type DebugFlags* = object
  xbits*: uint32
const DebugFlags_BIGGEST_ALLOWED* = DebugFlags()

type LargeFlags* = object
  xbits*: uint64
const LargeFlags_LARGE_SHIFT* = LargeFlags()
const LargeFlags_INVERTED* = LargeFlags()

type OutOfLine* = object
  x0*: uint32
const OutOfLine_A* = OutOfLine()
const OutOfLine_B* = OutOfLine()
const OutOfLine_AB* = OutOfLine()

proc root*(flags: AlignFlags,
           bigger_flags: DebugFlags,
           largest_flags: LargeFlags,
           out_of_line: OutOfLine): void {.importc: "root".}
