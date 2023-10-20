## Constants shared by multiple CSS Box Alignment properties
#
# These constants match Gecko's `NS_STYLE_ALIGN_*` constants.
type AlignFlags* = object
  bits*: uint8

type DebugFlags* = object
  bits*: uint32

type LargeFlags* = object
  bits*: uint64

type OutOfLine* = object
  x_0*: uint32

proc root*(flags: AlignFlags,
           bigger_flags: DebugFlags,
           largest_flags: LargeFlags,
           out_of_line: OutOfLine): void {.importc: "root".}
