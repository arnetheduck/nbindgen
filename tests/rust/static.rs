#[no_mangle]
pub static NUMBER: i32 = 10;

#[repr(C)]
struct TFoo {
}

struct TBar {
}

#[no_mangle]
pub static mut FOO: TFoo = TFoo { };
#[no_mangle]
pub static BAR: TBar = TBar { };

#[no_mangle]
pub extern "C" fn root() { }
