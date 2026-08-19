#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

#[ext(spec_only)]
use prover::prover::{requires, ensures};

public fun add_up(x: u8, y: u8): u8 {
    let r = x + y;
    r
}

#[ext(spec(prove))] #[allow(unused_function)]
fun add_up_spec(x: u8, y: u8): u8 {
    requires(x <= 127);
    let r = add_up(x, x); // <=== wrong call - should be add_up(x, y)
    ensures(r.to_int() == x.to_int().add(x.to_int()));
    r
}

fun add_up_caller(x: u8): u8 {
    add_up(1, x)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun add_up_caller_spec(x: u8): u8 {
    let r = add_up_caller(x);
    ensures(r == 2); // <== should not be provable, but it is
    r
}