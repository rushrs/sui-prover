module 0x42::pure_enum_match;

#[ext(spec_only)]
use prover::prover::ensures;

public enum E has copy, drop {
    A,
    B(u8),
}

#[ext(pure)]
public fun f(e: E): bool {
    match (e) {
        E::A => true,
        E::B(v) => v > 0,
    }
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_a() {
    ensures(f(E::A))
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_b_one() {
    ensures(f(E::B(1)))
}
