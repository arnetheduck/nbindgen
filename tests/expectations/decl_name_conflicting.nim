type BindingType* {.size: sizeof(uint32).} = enum
  Buffer
  NotBuffer

type BindGroupLayoutEntry* = object
  ty*: BindingType

proc root*(entry: BindGroupLayoutEntry): void {.importc: "root".}
