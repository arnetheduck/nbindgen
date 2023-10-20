type Str* = pointer

type HashTable_Str_c_char_false* = object
  num_buckets*: uint
  capacity*: uint
  occupied*: pointer
  keys*: ptr Str
  vals*: pointer

type MySet* = HashTable_Str_c_char_false

type SetCallback* = proc(key: Str): void

type HashTable_Str_u64_true* = object
  num_buckets*: uint
  capacity*: uint
  occupied*: pointer
  keys*: ptr Str
  vals*: pointer

type MapCallback* = proc(key: Str, val: uint64): void

proc new_set*(): ptr MySet {.importc: "new_set".}

proc set_for_each*(set: ptr MySet, callback: SetCallback): void {.importc: "set_for_each".}

proc new_map*(): ptr HashTable_Str_u64_true {.importc: "new_map".}

proc map_for_each*(map: ptr HashTable_Str_u64_true,
                   callback: MapCallback): void {.importc: "map_for_each".}
