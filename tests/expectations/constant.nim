const FOO* = 10

const DELIMITER* = ':'

const LEFTCURLY* = '{'

const QUOTE* = '\''

const TAB* = '\t'

const NEWLINE* = '\n'

const HEART* = U'\U00002764'

const EQUID* = U'\U00010083'

const ZOM* = 3.14

const POS_ONE* = 1

const NEG_ONE* = -1

const SHIFT* = 3

const XBOOL* = 1

const XFALSE* = ((0 shl SHIFT) or XBOOL)

const XTRUE* = (1 shl (SHIFT or XBOOL))

const CAST* = cast[uint8]('A')

const DOUBLE_CAST* = cast[uint32](cast[float32](1))

proc root*(x: Foo): void {.importc: "root".}
