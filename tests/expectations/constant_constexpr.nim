const CONSTANT_I64* = 216

const CONSTANT_FLOAT32* = 312.292

const DELIMITER* = ':'

const LEFTCURLY* = '{'

type Foo* = object
  x*: int32

const SomeFoo* = Foo(x: 99)
