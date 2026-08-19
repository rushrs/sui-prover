#[allow(unused_use)]
module 0x42::dynamic_fields {
    #[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
    #[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
    #[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
    #[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
    #[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
    #[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;
    use std::u128;

    public struct Parent has key {
        id: UID,
    }

    fun sqrt(x: u128, ctx: &mut TxContext): u64 {
        u128::sqrt(x) as u64
    }

    #[ext(spec_only)]
    use prover::prover::ensures;

    #[ext(spec(prove))] #[allow(unused_function)]
    fun sqrt_spec(x: u128, ctx: &mut TxContext): u64 {
        let x_int = x.to_int();

        let result = sqrt(x, ctx);

        let result_int = result.to_int();

        let parent_id = object::new(ctx);
        let mut parent = Parent { id: parent_id };

        ensures(result_int.mul(result_int).lte(x_int));
        ensures(result_int.add(1u64.to_int()).mul(result_int.add(1u64.to_int())).gt(x_int));

        transfer::share_object(parent);

        result
    }
}
