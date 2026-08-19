module specs::funds_accumulator_spec;

use prover::prover::{drop, fresh};


#[ext(spec(target = sui::funds_accumulator::add_to_accumulator_address))]
  public fun add_to_accumulator_address_spec<T: store>(
      accumulator: address,
      recipient: address,
      value: T,
  ) {
    drop(value)
  }

#[ext(spec(target = sui::funds_accumulator::withdraw_from_accumulator_address))]
  public fun withdraw_from_accumulator_address_spec<T: store>(
      accumulator: address,
      owner: address,
      value: u256,
  ): T {
    fresh<T>()
  }
