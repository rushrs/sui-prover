#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::ensures;
use prover::vector_iter::sum_range;


#[ext(spec(prove))] #[allow(unused_function)]
fun test_sum() {
    let v2 = vector[5u64, 15, 25, 35, 45];
    let v2_sum = sum_range(&v2, 1, 3);

    ensures(v2_sum == 50u64.to_int()); // Should fails because sum [1,3) is 40
}
