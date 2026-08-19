#[allow(unused, unused_use)]
module 0x42::quantifiers_range_count_pure_ok;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)]
use prover::vector_iter::range_count;

#[ext(spec_only)]
use prover::integer::Integer;

#[ext(pure)]
fun is_even(x: u64): bool {
    x % 2 == 0
}

#[ext(pure)]
fun count_evens_in_range(start: u64, end: u64): Integer {
    range_count!(start, end, |x| is_even(x))
}

#[ext(spec(prove, extra_bpl = b"range_count_pure.ok.bpl"))] #[allow(unused_function)]
fun test_range_count_pure() {
    // Count even numbers in [0, 6) = {0, 2, 4} = 3
    ensures(count_evens_in_range(0, 6) == 3u64.to_int());
}
