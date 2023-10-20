#[repr(C)]
struct TFoo {
    a: i32,
    b: u32,
}

struct TBar {
    a: i32,
    b: u32,
}

impl Foo {
    pub const FOO: TFoo = TFoo { a: 42, b: 47, };
    pub const FOO2: Self = TFoo { a: 42, b: 47, };
    pub const FOO3: Self = Self { a: 42, b: 47, };
    pub const BAZ: TBar = TBar { a: 42, b: 47, };
}

pub const BAR: TFoo = TFoo { a: 42, b: 1337, };
pub const BAZZ: TBar = TBar { a: 42, b: 1337, };

#[no_mangle]
pub extern "C" fn root(x: TFoo, bar: TBar) { }
