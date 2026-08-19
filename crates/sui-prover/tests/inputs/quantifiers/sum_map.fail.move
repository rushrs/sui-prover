#[allow(unused, unused_use)]
module 0x42::quantifiers_sum_map_fail;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)]
use prover::vector_iter::{sum_map, sum_map_range};

#[ext(pure)]
fun x_plus_10(x: &u64): u64 {
    if (*x > std::u64::max_value!() - 10) {
        std::u64::max_value!()
    } else {
        *x + 10
    }
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_sum_map_fail() {
    let v = vector[10, 20, 30, 40];

    // This should fail because sum_map is 140
    ensures(sum_map!<u64, u64>(&v, |x| x_plus_10(x)) == 100u64.to_int());
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_sum_map_range_fail() {
    let v = vector[100, 200, 300, 400];

    // This should fail because range [0, 2) sum is 320
    ensures(sum_map_range!<u64, u64>(&v, 0, 2, |x| x_plus_10(x)) == 300u64.to_int());
}
