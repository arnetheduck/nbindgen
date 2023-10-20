#define CF_SWIFT_NAME(_name) __attribute__((swift_name(#_name)))



type Opaque* {.incompleteStruct.} = object

type SelfTypeTestStruct* = object
  xtimes*: uint8

type PointerToOpaque* = object
  xptr*: ptr Opaque

proc rust_print_hello_world*(): void CF_SWIFT_NAME(rust_print_hello_world()) {.importc: "rust_print_hello_world".}

proc SelfTypeTestStruct_should_exist_ref*(self: ptr SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_ref(self:)) {.importc: "SelfTypeTestStruct_should_exist_ref".}

proc SelfTypeTestStruct_should_exist_ref_mut*(self: ptr SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_ref_mut(self:)) {.importc: "SelfTypeTestStruct_should_exist_ref_mut".}

proc SelfTypeTestStruct_should_not_exist_box*(self: ptr SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_not_exist_box(self:)) {.importc: "SelfTypeTestStruct_should_not_exist_box".}

proc SelfTypeTestStruct_should_not_exist_return_box*(): ptr SelfTypeTestStruct CF_SWIFT_NAME(SelfTypeTestStruct.should_not_exist_return_box()) {.importc: "SelfTypeTestStruct_should_not_exist_return_box".}

proc SelfTypeTestStruct_should_exist_annotated_self*(self: SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_annotated_self(self:)) {.importc: "SelfTypeTestStruct_should_exist_annotated_self".}

proc SelfTypeTestStruct_should_exist_annotated_mut_self*(self: SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_annotated_mut_self(self:)) {.importc: "SelfTypeTestStruct_should_exist_annotated_mut_self".}

proc SelfTypeTestStruct_should_exist_annotated_by_name*(self: SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_annotated_by_name(self:)) {.importc: "SelfTypeTestStruct_should_exist_annotated_by_name".}

proc SelfTypeTestStruct_should_exist_annotated_mut_by_name*(self: SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_annotated_mut_by_name(self:)) {.importc: "SelfTypeTestStruct_should_exist_annotated_mut_by_name".}

proc SelfTypeTestStruct_should_exist_unannotated*(self: SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_unannotated(self:)) {.importc: "SelfTypeTestStruct_should_exist_unannotated".}

proc SelfTypeTestStruct_should_exist_mut_unannotated*(self: SelfTypeTestStruct): void CF_SWIFT_NAME(SelfTypeTestStruct.should_exist_mut_unannotated(self:)) {.importc: "SelfTypeTestStruct_should_exist_mut_unannotated".}

proc free_function_should_exist_ref*(test_struct: ptr SelfTypeTestStruct): void CF_SWIFT_NAME(free_function_should_exist_ref(test_struct:)) {.importc: "free_function_should_exist_ref".}

proc free_function_should_exist_ref_mut*(test_struct: ptr SelfTypeTestStruct): void CF_SWIFT_NAME(free_function_should_exist_ref_mut(test_struct:)) {.importc: "free_function_should_exist_ref_mut".}

proc unnamed_argument*(a0: ptr SelfTypeTestStruct): void {.importc: "unnamed_argument".}

proc free_function_should_not_exist_box*(boxed: ptr SelfTypeTestStruct): void CF_SWIFT_NAME(free_function_should_not_exist_box(boxed:)) {.importc: "free_function_should_not_exist_box".}

proc free_function_should_exist_annotated_by_name*(test_struct: SelfTypeTestStruct): void CF_SWIFT_NAME(free_function_should_exist_annotated_by_name(test_struct:)) {.importc: "free_function_should_exist_annotated_by_name".}

proc free_function_should_exist_annotated_mut_by_name*(test_struct: SelfTypeTestStruct): void CF_SWIFT_NAME(free_function_should_exist_annotated_mut_by_name(test_struct:)) {.importc: "free_function_should_exist_annotated_mut_by_name".}

proc PointerToOpaque_create*(times: uint8): PointerToOpaque CF_SWIFT_NAME(PointerToOpaque.create(times:)) {.importc: "PointerToOpaque_create".}

proc PointerToOpaque_sayHello*(self: PointerToOpaque): void CF_SWIFT_NAME(PointerToOpaque.sayHello(self:)) {.importc: "PointerToOpaque_sayHello".}
