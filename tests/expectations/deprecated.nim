#define DEPRECATED_FUNC __attribute__((deprecated))
#define DEPRECATED_STRUCT __attribute__((deprecated))
#define DEPRECATED_ENUM __attribute__((deprecated))
#define DEPRECATED_FUNC_WITH_NOTE(...) __attribute__((deprecated(__VA_ARGS__)))
#define DEPRECATED_STRUCT_WITH_NOTE(...) __attribute__((deprecated(__VA_ARGS__)))
#define DEPRECATED_ENUM_WITH_NOTE(...) __attribute__((deprecated(__VA_ARGS__)))




type DeprecatedEnum* {.size: sizeof(int32).} = enum
  A

type DeprecatedEnumWithNote* {.size: sizeof(int32).} = enum
  B

type DEPRECATED_STRUCT DeprecatedStruct* = object
  xa*: int32

type DEPRECATED_STRUCT_WITH_NOTE("This is a note") DeprecatedStructWithNote* = object
  xa*: int32

DEPRECATED_FUNC proc deprecated_without_note*(): void {.importc: "deprecated_without_note".}

proc deprecated_without_bracket*(): void {.importc: "deprecated_without_bracket".}

proc deprecated_with_note*(): void {.importc: "deprecated_with_note".}

proc deprecated_with_note_and_since*(): void {.importc: "deprecated_with_note_and_since".}

proc deprecated_with_note_which_requires_to_be_escaped*(): void {.importc: "deprecated_with_note_which_requires_to_be_escaped".}

proc dummy*(a: DeprecatedEnum,
            b: DeprecatedEnumWithNote,
            c: DeprecatedStruct,
            d: DeprecatedStructWithNote): void {.importc: "dummy".}
