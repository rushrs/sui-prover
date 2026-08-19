module 0x42::pure_single_field_unpack;

#[ext(spec_only)]
use prover::prover::{requires, val};

public struct S(u8) has copy, drop;

#[ext(pure)]
public fun unwrap(s: S): u8 {
    let S(x) = s;
    x
}

public fun f(s: S): u8 {
    s.unwrap() + 1
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun f_spec(s: S): u8 {
    let s0 = val(&s);
    requires(s0.unwrap() < 255);
    f(s)
}
