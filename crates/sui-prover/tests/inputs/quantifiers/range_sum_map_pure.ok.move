#[allow(unused, unused_use)]
module 0x42::quantifiers_range_sum_map_pure_ok;

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

#[ext(spec_only)]
use prover::integer::Integer;

#[ext(pure)]
fun identity(x: u64): u64 {
    x
}

#[ext(pure)]
fun sum_identity_in_range(start: u64, end: u64): Integer {
    range_sum_map!<u64>(start, end, |x| identity(x))
}

#[ext(spec(prove, extra_bpl = b"range_sum_map_pure.ok.bpl"))] #[allow(unused_function)]
fun test_range_sum_map_pure() {
    // Sum of i for i in [0, 4) = 0 + 1 + 2 + 3 = 6
    ensures(sum_identity_in_range(0, 4) == 6u64.to_int());
}
