// Tests the singleton axiom for sum_map:
//   sum_map_range(v, i, i+1, f) == f(v[i])
// Uses a symbolic vector and index to force the axiom to fire.

#[allow(unused, unused_use)]
module 0x42::quantifiers_sum_map_singleton_ok;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

#[ext(spec_only)]
use prover::prover::{ensures, requires};

#[ext(spec_only)]
use prover::vector_iter::sum_map_range;

#[ext(pure)]
fun plus_one(x: &u64): u64 {
    if (*x == std::u64::max_value!()) {
        std::u64::max_value!()
    } else {
        *x + 1
    }
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_sum_map_singleton(v: &vector<u64>, i: u64) {
    requires(i < vector::length(v));
    ensures(
        sum_map_range!<u64, u64>(v, i, i + 1, |x| plus_one(x))
            == plus_one(vector::borrow(v, i)).to_int()
    );
}
