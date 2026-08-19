// Loop test for range_count: prove that a code loop that increments a counter
// for each odd index in [0, n) matches `range_count!(0, n, is_odd)`.
// Exercises the left-step / right-step axioms of range_count.

#[allow(unused_use)]
module 0x42::range_count_loop_ok;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{ensures, invariant};
use prover::vector_iter::range_count;

#[ext(pure)]
fun is_odd(x: u64): bool {
    x % 2 == 1
}

fun count_odd_range(n: u64): u64 {
    let mut i = 0;
    let mut c: u64 = 0;
    invariant!(|| ensures(
        i <= n
            && c.to_int() == range_count!(0, i, |j| is_odd(j))
    ));
    while (i < n) {
        if (is_odd(i)) {
            c = c + 1
        };
        i = i + 1;
    };
    c
}

#[ext(spec(prove))] #[allow(unused_function)]
fun count_odd_range_spec(n: u64): u64 {
    let r = count_odd_range(n);
    ensures(r.to_int() == range_count!(0, n, |j| is_odd(j)));
    r
}
