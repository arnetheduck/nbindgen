
type Str* = pointer

type HashTable_1Str_2c_char_2false* = object
  xnum_buckets*: uint
  xcapacity*: uint
  xoccupied*: pointer
  xkeys*: ptr Str
  xvals*: pointer

type MySet* = HashTable_1Str_2c_char_2false

type SetCallback* = proc(key: Str): void

type HashTable_1Str_2u64_2true* = object
  xnum_buckets*: uint
  xcapacity*: uint
  xoccupied*: pointer
  xkeys*: ptr Str
  xvals*: pointer

type MapCallback* = proc(key: Str, val: uint64): void

proc new_set*(): ptr MySet {.importc: "new_set".}

proc set_for_each*(set: ptr MySet, callback: SetCallback): void {.importc: "set_for_each".}

proc new_map*(): ptr HashTable_1Str_2u64_2true {.importc: "new_map".}

proc map_for_each*(map: ptr HashTable_1Str_2u64_2true,
                   callback: MapCallback): void {.importc: "map_for_each".}
