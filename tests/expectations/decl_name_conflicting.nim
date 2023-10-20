
type BindingType* {.size: sizeof(uint32).} = enum
  Buffer
  NotBuffer

type BindGroupLayoutEntry* = object
  xty*: BindingType

proc root*(entry: BindGroupLayoutEntry): void {.importc: "root".}
