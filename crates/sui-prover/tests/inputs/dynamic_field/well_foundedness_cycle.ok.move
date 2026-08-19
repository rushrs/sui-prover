module 0x42::foo;

use prover::prover::ensures;
use sui::dynamic_field as df;
use sui::table;

public struct GlobalConfig has key {
    id: UID,
}

public struct FeeKey has copy, store, drop {}

#[ext(pure)]
fun fee_value(config: &GlobalConfig): u64 {
    if (df::exists_with_type<FeeKey, table::Table<u64, u64>>(&config.id, FeeKey {})) {
        let fees = df::borrow<FeeKey, table::Table<u64, u64>>(&config.id, FeeKey {});
        if (table::contains(fees, 0)) {
            *table::borrow(fees, 0)
        } else {
            0
        }
    } else {
        0
    }
}

public fun set_fee(config: &mut GlobalConfig, amount: u64, ctx: &mut TxContext) {
    let uid = &mut config.id;
    let key = FeeKey {};

    if (!df::exists_with_type<FeeKey, table::Table<u64, u64>>(uid, key)) {
        df::add(uid, key, table::new<u64, u64>(ctx));
    };

    let fee_table: &mut table::Table<u64, u64> = df::borrow_mut(uid, key);

    if (!table::contains(fee_table, 0)) {
        table::add(fee_table, 0, 0);
    };

    let coin_fee = table::borrow_mut(fee_table, 0);
    *coin_fee = amount;
}

#[ext(spec(prove, no_opaque, ignore_abort))] #[allow(unused_function)]
public fun set_fee_spec(config: &mut GlobalConfig, amount: u64, ctx: &mut TxContext) {
    set_fee(config, amount, ctx);
    ensures(fee_value(config) == amount);
}
