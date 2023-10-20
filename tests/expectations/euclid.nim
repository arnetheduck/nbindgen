
type TypedLength_1f32_2UnknownUnit* = object
  x0*: float32

type TypedLength_1f32_2LayoutUnit* = object
  x0*: float32

type Length_1f32* = TypedLength_1f32_2UnknownUnit

type LayoutLength* = TypedLength_1f32_2LayoutUnit

type TypedSideOffsets2D_1f32_2UnknownUnit* = object
  xtop*: float32
  xright*: float32
  xbottom*: float32
  xleft*: float32

type TypedSideOffsets2D_1f32_2LayoutUnit* = object
  xtop*: float32
  xright*: float32
  xbottom*: float32
  xleft*: float32

type SideOffsets2D_1f32* = TypedSideOffsets2D_1f32_2UnknownUnit

type LayoutSideOffsets2D* = TypedSideOffsets2D_1f32_2LayoutUnit

type TypedSize2D_1f32_2UnknownUnit* = object
  xwidth*: float32
  xheight*: float32

type TypedSize2D_1f32_2LayoutUnit* = object
  xwidth*: float32
  xheight*: float32

type Size2D_1f32* = TypedSize2D_1f32_2UnknownUnit

type LayoutSize2D* = TypedSize2D_1f32_2LayoutUnit

type TypedPoint2D_1f32_2UnknownUnit* = object
  xx*: float32
  xy*: float32

type TypedPoint2D_1f32_2LayoutUnit* = object
  xx*: float32
  xy*: float32

type Point2D_1f32* = TypedPoint2D_1f32_2UnknownUnit

type LayoutPoint2D* = TypedPoint2D_1f32_2LayoutUnit

type TypedRect_1f32_2UnknownUnit* = object
  xorigin*: TypedPoint2D_1f32_2UnknownUnit
  xsize*: TypedSize2D_1f32_2UnknownUnit

type TypedRect_1f32_2LayoutUnit* = object
  xorigin*: TypedPoint2D_1f32_2LayoutUnit
  xsize*: TypedSize2D_1f32_2LayoutUnit

type Rect_1f32* = TypedRect_1f32_2UnknownUnit

type LayoutRect* = TypedRect_1f32_2LayoutUnit

type TypedTransform2D_1f32_2UnknownUnit_2LayoutUnit* = object
  xm11*: float32
  xm12*: float32
  xm21*: float32
  xm22*: float32
  xm31*: float32
  xm32*: float32

type TypedTransform2D_1f32_2LayoutUnit_2UnknownUnit* = object
  xm11*: float32
  xm12*: float32
  xm21*: float32
  xm22*: float32
  xm31*: float32
  xm32*: float32

proc root*(length_a: TypedLength_1f32_2UnknownUnit,
           length_b: TypedLength_1f32_2LayoutUnit,
           length_c: Length_1f32,
           length_d: LayoutLength,
           side_offsets_a: TypedSideOffsets2D_1f32_2UnknownUnit,
           side_offsets_b: TypedSideOffsets2D_1f32_2LayoutUnit,
           side_offsets_c: SideOffsets2D_1f32,
           side_offsets_d: LayoutSideOffsets2D,
           size_a: TypedSize2D_1f32_2UnknownUnit,
           size_b: TypedSize2D_1f32_2LayoutUnit,
           size_c: Size2D_1f32,
           size_d: LayoutSize2D,
           point_a: TypedPoint2D_1f32_2UnknownUnit,
           point_b: TypedPoint2D_1f32_2LayoutUnit,
           point_c: Point2D_1f32,
           point_d: LayoutPoint2D,
           rect_a: TypedRect_1f32_2UnknownUnit,
           rect_b: TypedRect_1f32_2LayoutUnit,
           rect_c: Rect_1f32,
           rect_d: LayoutRect,
           transform_a: TypedTransform2D_1f32_2UnknownUnit_2LayoutUnit,
           transform_b: TypedTransform2D_1f32_2LayoutUnit_2UnknownUnit): void {.importc: "root".}
