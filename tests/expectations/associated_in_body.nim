
## Constants shared by multiple CSS Box Alignment properties
#
# These constants match Gecko's `NS_STYLE_ALIGN_*` constants.
type AlignFlags* = object
  xbits*: uint8
const AlignFlags_AUTO* = StyleAlignFlags()
const AlignFlags_NORMAL* = StyleAlignFlags()
const AlignFlags_START* = StyleAlignFlags()
const AlignFlags_END* = StyleAlignFlags()
const AlignFlags_ALIAS* = StyleAlignFlags()
const AlignFlags_FLEX_START* = StyleAlignFlags()
const AlignFlags_MIXED* = StyleAlignFlags()
const AlignFlags_MIXED_SELF* = StyleAlignFlags()

## An arbitrary identifier for a native (OS compositor) surface
type NativeSurfaceId* = object
  x0*: uint64
const NativeSurfaceId_DEBUG_OVERLAY* = StyleNativeSurfaceId()

type NativeTileId* = object
  xsurface_id*: StyleNativeSurfaceId
  xx*: int32
  xy*: int32
const NativeTileId_DEBUG_OVERLAY* = StyleNativeTileId()

proc root*(flags: StyleAlignFlags, tile: StyleNativeTileId): void {.importc: "root".}
