#[allow(unused_use)]
module 0x42::loop_invariant_external_clone_mut;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{requires, ensures};

public struct Foo {
    x: u64,
    y: u64,
}

public fun foo(s: &mut Foo) {
    let mut i = 0;
    while (i < s.y) {
        s.x = s.x + 1;
        i = i + 1;
    }
}

#[ext(spec_only(loop_inv(target = foo)), pure)] #[allow(unused_function)]
public fun foo_inv(s: &Foo, i: u64, __old_s: &Foo): bool {
    i <= s.y &&
    s.x.to_int() == __old_s.x.to_int().add(i.to_int()) &&
    s.y == __old_s.y
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(s: &mut Foo) {
    let old_x = s.x;
    let old_y = s.y;
    requires((s.x as u128) + (s.y as u128) < std::u64::max_value!() as u128);
    foo(s);
    ensures(s.x == old_x + old_y);
    ensures(s.y == old_y);
}
