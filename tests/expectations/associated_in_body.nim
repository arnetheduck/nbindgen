## Constants shared by multiple CSS Box Alignment properties
#
# These constants match Gecko's `NS_STYLE_ALIGN_*` constants.
type StyleAlignFlags* = object
  bits*: uint8

## An arbitrary identifier for a native (OS compositor) surface
type StyleNativeSurfaceId* = object
  x_0*: uint64

type StyleNativeTileId* = object
  surface_id*: StyleNativeSurfaceId
  x*: int32
  y*: int32

proc root*(flags: StyleAlignFlags, tile: StyleNativeTileId): void {.importc: "root".}
