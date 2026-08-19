module specs::config_spec;

use prover::prover::fresh;

#[ext(spec(target = sui::config::read_setting_impl))]
public fun read_setting_impl_spec<
    FieldSettingValue: key,
    SettingValue: store,
    SettingDataValue: store,
    Value: copy + drop + store,
  >(
      config: address,
      name: address,
      current_epoch: u64,
  ): Option<Value> {
    fresh<Option<Value>>()
  }
