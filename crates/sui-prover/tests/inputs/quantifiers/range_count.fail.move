#[allow(unused, unused_use)]
module 0x42::quantifiers_range_count_fail;

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

#[ext(pure)]
fun is_even(x: u64): bool {
    x % 2 == 0
}

#[ext(pure)]
fun is_10(x: u64): bool {
    x == 10
}

#[ext(pure)]
fun is_greater_than_5(x: u64): bool {
    x > 5
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_range_count_wrong_count() {
    // Range [0, 4) = {0, 1, 2, 3} -> evens: 0, 2 = 2
    // FAIL: claiming count is 3 when it should be 2
    ensures(range_count!(0, 4, |x| is_even(x)) == 3u64.to_int());
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_range_count_off_by_one() {
    // Range [0, 10) has values {6, 7, 8, 9} > 5, so count is 4
    // FAIL: claiming count is 5
    ensures(range_count!(0, 10, |x| is_greater_than_5(x)) == 5u64.to_int());
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_range_count_wrong_value_check() {
    // Range [0, 15) contains exactly one 10
    // FAIL: claiming count is 2
    ensures(range_count!(0, 15, |x| is_10(x)) == 2u64.to_int());
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_range_count_empty_not_zero() {
    // Empty range should return 0
    // FAIL: claiming empty range has count 1
    ensures(range_count!(5, 5, |x| is_even(x)) == 1u64.to_int());
}
