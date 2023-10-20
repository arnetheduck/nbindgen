proc unnamed*(a0: pointer): void {.importc: "unnamed".}

proc pointer_test*(a: pointer): void {.importc: "pointer_test".}

proc print_from_rust*(): void {.importc: "print_from_rust".}
