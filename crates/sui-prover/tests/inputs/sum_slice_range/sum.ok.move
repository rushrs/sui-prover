#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{requires, ensures};
use prover::vector_iter::sum;


#[ext(spec(prove))] #[allow(unused_function)]
fun test_sum(mut v: vector<u64>) {
    let mut v1 = vector[10u64, 20, 30];
    let mut v2 = vector[5u64, 15];
    let v3: vector<u64> = vector[]; // empty vector
    requires(vector::length(&v) == 2);

    // Use borrow_mut to modify vector elements
    *vector::borrow_mut(&mut v1, 0) = 100u64;
    *vector::borrow_mut(&mut v1, 1) = 200u64;
    *vector::borrow_mut(&mut v1, 2) = 400u64;

    *vector::borrow_mut(&mut v2, 0) = 0u64;
    *vector::borrow_mut(&mut v2, 1) = 25u64;

    *vector::borrow_mut(&mut v, 0) = 50u64;
    *vector::borrow_mut(&mut v, 1) = 75u64;

    let v1_sum = sum(&v1);
    let v2_sum = sum(&v2);
    let v3_sum = sum(&v3);
    let v_sum = sum(&v);

    ensures(v1_sum == 700u64.to_int());
    ensures(v2_sum == 25u64.to_int());
    ensures(v3_sum == 0u64.to_int());
    ensures(v_sum == 125u64.to_int());
}
