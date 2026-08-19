module 0x42::object_id_test;

use prover::prover::ensures;

public struct S has key, store {
    id: UID,
}

#[ext(spec(prove))] #[allow(unused_function)]
fun purity_spec(s: &S) {
    let id1 = object::id(s);
    let id2 = object::id(s);
    ensures(id1 == id2);
}
