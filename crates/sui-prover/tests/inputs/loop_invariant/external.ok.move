#[allow(unused_use)]
module 0x42::loop_invariant_external_ok;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{requires, ensures, clone};
use prover::ghost;
use prover::integer::Integer;

#[ext(spec_only(loop_inv(target = test0_spec)), no_abort)] #[allow(unused_function)]
fun loop_inv_0(i: u64, n: u64): bool {
    i <= n
}

#[ext(spec_only(loop_inv(target = test1_spec)), no_abort)] #[allow(unused_function)]
fun loop_inv_1(i: u64, n: u64, s: u128): bool {
    i <= n && (s == (i as u128) * ((i as u128) + 1) / 2)
}

#[ext(spec_only(loop_inv(target = test2_spec)), no_abort)] #[allow(unused_function)]
fun loop_inv_2(i: u64, n: u64, s: u128): bool {
    i <= n && (s == (i as u128) * ((i as u128) + 1) / 2)
}

#[ext(spec_only(loop_inv(target = test3_spec)), no_abort)] #[allow(unused_function)]
fun loop_inv_3(n: u64, old_n: u64, s: u128): bool {
    n <= old_n && (s == ((old_n as u128) - (n as u128)) * ((old_n as u128) + (n as u128) + 1) / 2)
}

#[ext(spec_only(loop_inv(target = test4_spec)), no_abort)] #[allow(unused_function)]
fun loop_inv_4(i: u64, n: u64, s: u128): bool {
    i < n && (s == (i as u128) * ((i as u128) + 1) / 2)
}

#[ext(spec_only(loop_inv(target = test6_spec)), no_abort)] #[allow(unused_function)]
fun loop_inv_6(i: u64, n: u64, old_s: u128, ss: u128): bool {
    i <= n && ((ss as u256) == (old_s as u256) + (i as u256) * ((i as u256) + 1) / 2)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test0_spec(n: u64) {
    let mut i = 0;

    while (i < n) {
        i = i + 1;
    };

    ensures(i == n);
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test1_spec(n: u64): u128 {
    let mut s: u128 = 0;
    let mut i = 0;

    while (i < n) {
        i = i + 1;
        s = s + (i as u128);
    };

    ensures(s == (n as u128) * ((n as u128) + 1) / 2);
    s
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test2_spec(n: u64): u128 {
    let mut s: u128 = 0;
    let mut i = 0;

    while (i < n) {
        i = i + 1;
        s = s + (i as u128);
    };

    ensures(s == (n as u128) * ((n as u128) + 1) / 2);
    s
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test3_spec(mut n: u64): u128 {
    let mut s: u128 = 0;

    let old_n: &u64 = clone!(&n);
    while (n > 0) {
        s = s + (n as u128);
        n = n - 1;
    };

    ensures(s == (*old_n as u128) * ((*old_n as u128) + 1) / 2);
    s
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test4_spec(n: u64): u128 {
    requires(0 < n);

    let mut s: u128 = 0;
    let mut i = 0;

    loop {
        i = i + 1;
        s = s + (i as u128);
        if (i >= n) {
            break
        }
    };

    ensures(s == (n as u128) * ((n as u128) + 1) / 2);
    s
}

public struct SpecSum {}

fun emit_u64(_x: u64) {}

#[ext(spec)] #[allow(unused_function)]
fun emit_u64_spec(x: u64) {
    ghost::declare_global_mut<SpecSum, Integer>();
    let old_sum = *ghost::global<SpecSum, Integer>();
    emit_u64(x);
    ensures(ghost::global<SpecSum, Integer>() == old_sum.add(x.to_int()));
}

#[ext(spec(prove, ignore_abort))] #[allow(unused_mut_parameter, unused_function)]
fun test6_spec(s: &mut u128, n: u64) {
    // mutable references are not allowed
    let old_s: &u128 = clone!(s);
    let mut ss = *s;

    let mut i = 0;

    while (i < n) {
        i = i + 1;
        ss = ss + (i as u128);
    };

    ensures(ss == *old_s + (n as u128) * ((n as u128) + 1) / 2);
    ensures(i == n);
}
