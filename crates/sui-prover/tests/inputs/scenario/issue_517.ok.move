module 0x42::foo;

public fun f(x: u8): u8 {
    x
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun f_spec(x: u8): u8 {
    f(x)
}
