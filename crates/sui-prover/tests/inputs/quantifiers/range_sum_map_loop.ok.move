// Loop test for range_sum_map: accumulate 0/1 contributions (odd or not)
// and prove the running sum matches range_sum_map over the processed prefix.
// Bounded contributions keep the sum <= i, so no overflow concerns.

#[allow(unused_use)]
module 0x42::range_sum_map_loop_ok;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{ensures, invariant};
use prover::vector_iter::range_sum_map;

#[ext(pure)]
fun odd_to_int(x: u64): u64 {
    if (x % 2 == 1) { 1 } else { 0 }
}

fun count_odd_via_range_sum(n: u64): u64 {
    let mut i = 0;
    let mut s: u64 = 0;
    invariant!(|| ensures(
        i <= n
            && s <= i
            && s.to_int() == range_sum_map!<u64>(0, i, |j| odd_to_int(j))
    ));
    while (i < n) {
        s = s + odd_to_int(i);
        i = i + 1;
    };
    s
}

#[ext(spec(prove))] #[allow(unused_function)]
fun count_odd_via_range_sum_spec(n: u64): u64 {
    let r = count_odd_via_range_sum(n);
    ensures(r.to_int() == range_sum_map!<u64>(0, n, |j| odd_to_int(j)));
    r
}
