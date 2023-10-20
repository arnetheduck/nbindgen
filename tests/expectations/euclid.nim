type TypedLength_f32_UnknownUnit* = object
  x_0*: float32

type TypedLength_f32_LayoutUnit* = object
  x_0*: float32

type Length_f32* = TypedLength_f32_UnknownUnit

type LayoutLength* = TypedLength_f32_LayoutUnit

type TypedSideOffsets2D_f32_UnknownUnit* = object
  top*: float32
  right*: float32
  bottom*: float32
  left*: float32

type TypedSideOffsets2D_f32_LayoutUnit* = object
  top*: float32
  right*: float32
  bottom*: float32
  left*: float32

type SideOffsets2D_f32* = TypedSideOffsets2D_f32_UnknownUnit

type LayoutSideOffsets2D* = TypedSideOffsets2D_f32_LayoutUnit

type TypedSize2D_f32_UnknownUnit* = object
  width*: float32
  height*: float32

type TypedSize2D_f32_LayoutUnit* = object
  width*: float32
  height*: float32

type Size2D_f32* = TypedSize2D_f32_UnknownUnit

type LayoutSize2D* = TypedSize2D_f32_LayoutUnit

type TypedPoint2D_f32_UnknownUnit* = object
  x*: float32
  y*: float32

type TypedPoint2D_f32_LayoutUnit* = object
  x*: float32
  y*: float32

type Point2D_f32* = TypedPoint2D_f32_UnknownUnit

type LayoutPoint2D* = TypedPoint2D_f32_LayoutUnit

type TypedRect_f32_UnknownUnit* = object
  origin*: TypedPoint2D_f32_UnknownUnit
  sizex*: TypedSize2D_f32_UnknownUnit

type TypedRect_f32_LayoutUnit* = object
  origin*: TypedPoint2D_f32_LayoutUnit
  sizex*: TypedSize2D_f32_LayoutUnit

type Rect_f32* = TypedRect_f32_UnknownUnit

type LayoutRect* = TypedRect_f32_LayoutUnit

type TypedTransform2D_f32_UnknownUnit_LayoutUnit* = object
  m11*: float32
  m12*: float32
  m21*: float32
  m22*: float32
  m31*: float32
  m32*: float32

type TypedTransform2D_f32_LayoutUnit_UnknownUnit* = object
  m11*: float32
  m12*: float32
  m21*: float32
  m22*: float32
  m31*: float32
  m32*: float32

proc root*(length_a: TypedLength_f32_UnknownUnit,
           length_b: TypedLength_f32_LayoutUnit,
           length_c: Length_f32,
           length_d: LayoutLength,
           side_offsets_a: TypedSideOffsets2D_f32_UnknownUnit,
           side_offsets_b: TypedSideOffsets2D_f32_LayoutUnit,
           side_offsets_c: SideOffsets2D_f32,
           side_offsets_d: LayoutSideOffsets2D,
           size_a: TypedSize2D_f32_UnknownUnit,
           size_b: TypedSize2D_f32_LayoutUnit,
           size_c: Size2D_f32,
           size_d: LayoutSize2D,
           point_a: TypedPoint2D_f32_UnknownUnit,
           point_b: TypedPoint2D_f32_LayoutUnit,
           point_c: Point2D_f32,
           point_d: LayoutPoint2D,
           rect_a: TypedRect_f32_UnknownUnit,
           rect_b: TypedRect_f32_LayoutUnit,
           rect_c: Rect_f32,
           rect_d: LayoutRect,
           transform_a: TypedTransform2D_f32_UnknownUnit_LayoutUnit,
           transform_b: TypedTransform2D_f32_LayoutUnit_UnknownUnit): void {.importc: "root".}
