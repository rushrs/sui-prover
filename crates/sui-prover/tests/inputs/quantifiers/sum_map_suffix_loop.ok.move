// Loop test with a suffix invariant for `sum_map`. The invariant says:
//
//   s + sum_map_range(v, i, n, f) == sum_map(v, f)
//
// Preserving this across the loop body needs sum_map's start-step axiom:
//   sum_map(v, i, n, f) == f(v[i]) + sum_map(v, i+1, n, f).

#[allow(unused_use)]
module 0x42::sum_map_suffix_loop_ok;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{ensures, invariant};
use prover::vector_iter::{sum_map, sum_map_range};

// Map to 0 or 1 so the running sum stays bounded and doesn't overflow.
#[ext(pure)]
fun odd_to_int(x: &u64): u64 {
    if ((*x) % 2 == 1) { 1 } else { 0 }
}

fun count_odd_via_sum_suffix(v: &vector<u64>): u64 {
    let mut i = 0;
    let mut s: u64 = 0;
    invariant!(|| ensures(
        i <= v.length()
            && s <= i
            && (s.to_int() + sum_map_range!(v, i, v.length(), |j| odd_to_int(j)))
                == sum_map!(v, |j| odd_to_int(j))
    ));
    while (i < v.length()) {
        s = s + odd_to_int(&v[i]);
        i = i + 1;
    };
    s
}

#[ext(spec(prove))] #[allow(unused_function)]
fun count_odd_via_sum_suffix_spec(v: &vector<u64>): u64 {
    let r = count_odd_via_sum_suffix(v);
    ensures(r.to_int() == sum_map!(v, |j| odd_to_int(j)));
    r
}
