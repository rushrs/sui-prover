#[allow(unused)]
module 0x42::quantifiers_forall_exists_ok;

#[ext(spec_only)]
use prover::prover::{forall, exists, ensures};

#[ext(pure)]
fun x_is_10(x: &u64): bool {
    x == 10
}

#[ext(pure)]
fun x_is_gte_0(x: &u64): bool {
    *x >= 0
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_spec() {
    let positive = forall!<u64>(|x| x_is_gte_0(x));
    ensures(positive);
    ensures(exists!<u64>(|x| x_is_10(x)));
}
