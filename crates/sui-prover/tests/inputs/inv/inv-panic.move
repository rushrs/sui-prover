module 0x42::boogie_unknown;

use sui::versioned::{create, Versioned};
public fun bar(ctx: &mut TxContext): Versioned {
    create(0, 1u8, ctx)
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun bar_spec(ctx: &mut TxContext): Versioned {
    bar(ctx)
}

#[ext(spec_only)]
use sui::random::RandomInner;

#[ext(spec)] #[allow(unused_function, unused_variable)]
fun RandomInner_inv(x: &RandomInner): bool { true }