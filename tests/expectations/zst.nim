type TraitObject* = object
  data*: pointer
  vtable*: pointer

proc root*(ptrx: pointer, t: TraitObject): pointer {.importc: "root".}
