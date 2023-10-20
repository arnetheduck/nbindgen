proc ptr_as_array*(n: uint32, arg: uint32, v: pointer): void {.importc: "ptr_as_array".}

proc ptr_as_array1*(n: uint32, arg: uint32, v: uint64): void {.importc: "ptr_as_array1".}

proc ptr_as_array2*(n: uint32, arg: uint32, v: uint64): void {.importc: "ptr_as_array2".}

proc ptr_as_array_wrong_syntax*(arg: pointer,
                                v: pointer,
                                pointer): void {.importc: "ptr_as_array_wrong_syntax".}

proc ptr_as_array_unnamed*(a0: pointer, a1: pointer): void {.importc: "ptr_as_array_unnamed".}
