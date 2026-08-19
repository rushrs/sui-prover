module prover::real {
    #[ext(spec_only)]
    use prover::integer::Integer;

    #[ext(spec_only)]
    native public struct Real has copy, drop, store;

    #[ext(spec_only)] native public fun from_integer(x: Integer): Real;
    #[ext(spec_only)] native public fun to_integer(x: Real): Integer;

    #[ext(spec_only, pure)] public fun from_u8(x: u8): Real {
        from_integer(prover::integer::from_u8(x))
    }
    #[ext(spec_only, pure)] public fun from_u16(x: u16): Real {
        from_integer(prover::integer::from_u16(x))
    }
    #[ext(spec_only, pure)] public fun from_u32(x: u32): Real {
        from_integer(prover::integer::from_u32(x))
    }
    #[ext(spec_only, pure)] public fun from_u64(x: u64): Real {
        from_integer(prover::integer::from_u64(x))
    }
    #[ext(spec_only, pure)] public fun from_u128(x: u128): Real {
        from_integer(prover::integer::from_u128(x))
    }
    #[ext(spec_only, pure)] public fun from_u256(x: u256): Real {
        from_integer(prover::integer::from_u256(x))
    }

    #[ext(spec_only, pure)] public fun to_u8(x: Real): u8 {
        prover::integer::to_u8(to_integer(x))
    }
    #[ext(spec_only, pure)] public fun to_u16(x: Real): u16 {
        prover::integer::to_u16(to_integer(x))
    }
    #[ext(spec_only, pure)] public fun to_u32(x: Real): u32 {
        prover::integer::to_u32(to_integer(x))
    }
    #[ext(spec_only, pure)] public fun to_u64(x: Real): u64 {
        prover::integer::to_u64(to_integer(x))
    }
    #[ext(spec_only, pure)] public fun to_u128(x: Real): u128 {
        prover::integer::to_u128(to_integer(x))
    }
    #[ext(spec_only, pure)] public fun to_u256(x: Real): u256 {
        prover::integer::to_u256(to_integer(x))
    }

    #[ext(spec_only)] native public fun add(x: Real, y: Real): Real;
    #[ext(spec_only)] native public fun sub(x: Real, y: Real): Real;
    #[ext(spec_only)] native public fun neg(x: Real): Real;
    #[ext(spec_only)] native public fun mul(x: Real, y: Real): Real;
    #[ext(spec_only)] native public fun div(x: Real, y: Real): Real;
    #[ext(spec_only)] native public fun sqrt(x: Real): Real;
    #[ext(spec_only)] native public fun exp(x: Real, y: Integer): Real;

    #[ext(spec_only)] native public fun lt(x: Real, y: Real): bool;
    #[ext(spec_only)] native public fun gt(x: Real, y: Real): bool;
    #[ext(spec_only)] native public fun lte(x: Real, y: Real): bool;
    #[ext(spec_only)] native public fun gte(x: Real, y: Real): bool;
}
