## Some docs.
var FOO*: uint32

## The root of all evil.
#
# But at least it contains some more documentation as someone would expect
# from a simple test case like this.
#
# # Hint
# Always ensure that everything is properly documented, even if you feel lazy.
# **Sometimes** it is also helpful to include some markdown formatting.
#
# ////////////////////////////////////////////////////////////////////////////
#
# Attention:
#
#    This is an indentation test.
#    The indentation should be preserved in the generated documentation.
#
# ...and here is my shopping list to check that we do not mess with line breaks and indentation:
# - Bread
#    - Brown
#    - White
# - Milk
# - Eggs
proc root*(): void {.importc: "root".}

## In this block, we're testing indentation handling.
# Since all of these lines are equally indented, we want to discard the common leading whitespace,
#    but preserve the relative indentation and line breaks.
#
#    Including between paragraphs,
#
# - And
#   - within
#   - Lists
proc block_function*(): void {.importc: "block_function".}
