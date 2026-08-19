#[allow(unused, unused_use)]
module 0x42::quantifiers_range_sum_map_fail;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)]
use prover::vector_iter::range_sum_map;

#[ext(pure)]
fun identity(x: u64): u64 {
    x
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_range_sum_map_wrong_sum() {
    // Sum of i for i in [0, 4) = 6, not 7
    ensures(range_sum_map!<u64>(0, 4, |x| identity(x)) == 7u64.to_int());
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_range_sum_map_empty_not_zero() {
    // Empty range is 0, not 1
    ensures(range_sum_map!<u64>(5, 5, |x| identity(x)) == 1u64.to_int());
}
