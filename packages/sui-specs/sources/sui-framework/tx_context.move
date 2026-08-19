module specs::tx_context_spec;

use prover::prover::fresh;
use sui::tx_context::TxContext;


#[ext(spec(target = sui::tx_context::fresh_object_address))]
fun fresh_object_address_spec(ctx: &mut TxContext): address {
    fresh<address>()
}

#[ext(spec(target = sui::tx_context::derive_id))]
fun derive_id_spec(tx_hash: vector<u8>, ids_created: u64): address {
    fresh<address>()
}

#[ext(spec(target = sui::tx_context::fresh_id))]
fun fresh_id_spec(): address {
    fresh<address>()
}

#[ext(spec(target = sui::tx_context::native_ids_created))]
fun native_ids_created_spec(): u64 {
    fresh<u64>()
}

#[ext(spec(target = sui::tx_context::native_gas_budget))]
fun native_gas_budget_spec(): u64 {
    fresh<u64>()
}

#[ext(spec(target = sui::tx_context::native_sponsor))]
fun native_sponsor_spec(): vector<address> {
    fresh<vector<address>>()
}
