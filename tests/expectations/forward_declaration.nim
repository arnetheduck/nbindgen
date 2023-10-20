#if 0
''' '
#endif
#if defined(CBINDGEN_STYLE_TYPE)
/* ANONYMOUS STRUCTS DO NOT SUPPORT FORWARD DECLARATIONS!
#endif
#if 0
' '''
#endif




type StructInfo* = object
  xfields*: ptr ptr TypeInfo
  xnum_fields*: uint

type TypeData_Tag* = enum
  Primitive
  Struct

type TypeData* = object
  case tag*: TypeData_Tag

  of Struct:
    xstruct*: StructInfo
  else: discard

type TypeInfo* = object
  xdata*: TypeData

proc root*(x: TypeInfo): void {.importc: "root".}

#if 0
''' '
#endif
#if defined(CBINDGEN_STYLE_TYPE)
*/
#endif
#if 0
' '''
#endif
