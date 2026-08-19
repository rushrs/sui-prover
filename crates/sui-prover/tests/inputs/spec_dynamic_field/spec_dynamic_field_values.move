module 0x42::foo_spec;

use sui::versioned::{create, Versioned};

public fun bar(ctx: &mut TxContext): Versioned {
    create(0, 1u8, ctx)
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun bar_spec(ctx: &mut TxContext): Versioned {
    bar(ctx)
}