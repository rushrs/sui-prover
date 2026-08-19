module 0x42::foo;

#[ext(pure)]
fun vex(v: vector<u8>): vector<u8> {
    v
}

fun user() {
    let u = vector[1u8];
    assert!(vex(u).length() >= 0, 1);
}

#[ext(spec(prove, uninterpreted = vex))] #[allow(unused_function)]
fun user_spec() {
    user();
}
