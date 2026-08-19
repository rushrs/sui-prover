module 0x42::object_id_test;

use prover::prover::ensures;

public struct S has key, store {
    id: UID,
}

fun f(s: &S): ID {
    object::id(s)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun f_spec(s: &S) : ID {
    let r = f(s);
    ensures(r == object::id(s));
    r
}
