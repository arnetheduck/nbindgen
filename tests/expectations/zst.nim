
type TraitObject* = object
  xdata*: pointer
  xvtable*: pointer

proc root*(ptrx: pointer, t: TraitObject): pointer {.importc: "root".}
