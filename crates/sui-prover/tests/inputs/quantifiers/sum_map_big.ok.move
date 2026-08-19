// Stress test: sum_map on a larger concrete vector.

#[allow(unused, unused_use)]
module 0x42::quantifiers_sum_map_big_ok;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)]
use prover::vector_iter::sum_map;

#[ext(pure)]
fun double(x: &u64): u64 {
    if (*x > std::u64::max_value!() / 2) {
        std::u64::max_value!()
    } else {
        *x * 2
    }
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_sum_map_big() {
    let v = vector[1, 2, 3, 4, 5, 6, 7, 8];
    // Sum of doubles: 2 * (1+2+...+8) = 2 * 36 = 72
    ensures(sum_map!<u64, u64>(&v, |x| double(x)) == 72u64.to_int());
}
