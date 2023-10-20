proc test_camel_case*(fooBar: int32): void {.importc: "test_camel_case".}

proc test_pascal_case*(FooBar: int32): void {.importc: "test_pascal_case".}

proc test_snake_case*(foo_bar: int32): void {.importc: "test_snake_case".}

proc test_screaming_snake_case*(FOO_BAR: int32): void {.importc: "test_screaming_snake_case".}

proc test_gecko_case*(aFooBar: int32): void {.importc: "test_gecko_case".}
