module prover::integer {
    #[ext(spec_only)]
    native public struct Integer has copy, drop, store;

    #[ext(spec_only)] native public fun from_u8(x: u8): Integer;
    #[ext(spec_only)] native public fun from_u16(x: u16): Integer;
    #[ext(spec_only)] native public fun from_u32(x: u32): Integer;
    #[ext(spec_only)] native public fun from_u64(x: u64): Integer;
    #[ext(spec_only)] native public fun from_u128(x: u128): Integer;
    #[ext(spec_only)] native public fun from_u256(x: u256): Integer;

    #[ext(spec_only)] native public fun to_u8(x: Integer): u8;
    #[ext(spec_only)] native public fun to_u16(x: Integer): u16;
    #[ext(spec_only)] native public fun to_u32(x: Integer): u32;
    #[ext(spec_only)] native public fun to_u64(x: Integer): u64;
    #[ext(spec_only)] native public fun to_u128(x: Integer): u128;
    #[ext(spec_only)] native public fun to_u256(x: Integer): u256;

    #[ext(spec_only)] native public fun add(x: Integer, y: Integer): Integer;
    #[ext(spec_only)] native public fun sub(x: Integer, y: Integer): Integer;
    #[ext(spec_only)] native public fun neg(x: Integer): Integer;
    #[ext(spec_only)] native public fun mul(x: Integer, y: Integer): Integer;
    #[ext(spec_only)] native public fun div(x: Integer, y: Integer): Integer;
    #[ext(spec_only)] native public fun mod(x: Integer, y: Integer): Integer;
    #[ext(spec_only)] native public fun sqrt(x: Integer): Integer;
    #[ext(spec_only)] native public fun pow(x: Integer, y: Integer): Integer;

    #[ext(spec_only)] native public fun lt(x: Integer, y: Integer): bool;
    #[ext(spec_only)] native public fun gt(x: Integer, y: Integer): bool;
    #[ext(spec_only)] native public fun lte(x: Integer, y: Integer): bool;
    #[ext(spec_only)] native public fun gte(x: Integer, y: Integer): bool;

}
