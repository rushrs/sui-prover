module 0x42::foo;

public fun foo(x: u64) {
    if (x > 0) {}
}

#[ext(spec(prove))] #[allow(unused_function)]
fun foo_spec(x: u64) {
    foo(x);
}

public fun bar(x: u64) {
    if (x > 0) {} else {}
}

#[ext(spec(prove))] #[allow(unused_function)]
fun bar_spec(x: u64) {
    bar(x);
}
