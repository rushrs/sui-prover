module 0x42::foo;

fun foo(x: u64): u64 {
    bar(x)
}

fun bar(x: u64): u64 {
    x + 1
}

#[ext(spec(prove))] #[allow(unused_function)]
fun foo_spec(x: u64): u64 {
    foo(x)
}

#[ext(spec(prove, ignore_abort))] #[allow(unused_function)]
fun bar_spec(x: u64): u64 {
    bar(x)
}
