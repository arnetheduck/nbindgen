type DummyStruct* {.incompleteStruct.} = object

type EnumWithAssociatedConstantInImpl* {.incompleteStruct.} = object

type TransparentComplexWrappingStructTuple* = DummyStruct

type TransparentPrimitiveWrappingStructTuple* = uint32

type TransparentComplexWrappingStructure* = DummyStruct

type TransparentPrimitiveWrappingStructure* = uint32

type TransparentComplexWrapper_i32* = DummyStruct

type TransparentPrimitiveWrapper_i32* = uint32

type TransparentPrimitiveWithAssociatedConstants* = uint32
const TransparentPrimitiveWithAssociatedConstants_ZERO* = 0
const TransparentPrimitiveWithAssociatedConstants_ONE* = 1

type TransparentEmptyStructure* = object


const EnumWithAssociatedConstantInImpl_TEN* = 10

proc root*(a: TransparentComplexWrappingStructTuple,
           b: TransparentPrimitiveWrappingStructTuple,
           c: TransparentComplexWrappingStructure,
           d: TransparentPrimitiveWrappingStructure,
           e: TransparentComplexWrapper_i32,
           f: TransparentPrimitiveWrapper_i32,
           g: TransparentPrimitiveWithAssociatedConstants,
           h: TransparentEmptyStructure,
           i: EnumWithAssociatedConstantInImpl): void {.importc: "root".}
