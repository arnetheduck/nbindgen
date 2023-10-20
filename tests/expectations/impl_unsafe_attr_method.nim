type DummyStruct* = object
  dummy_field*: int32

proc new_dummy*(): DummyStruct {.importc: "new_dummy".}

proc new_dummy_param*(dummy_field: int32): DummyStruct {.importc: "new_dummy_param".}
