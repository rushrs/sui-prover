module specs::accumulator_spec;

use prover::prover::fresh;

#[ext(spec(target = sui::accumulator::emit_deposit_event))]
  public fun emit_deposit_event_spec<T>(
      accumulator: address,
      recipient: address,
      amount: u64,
  ) {
  }

#[ext(spec(target = sui::accumulator::emit_withdraw_event))]
  public fun emit_withdraw_event_spec<T>(
      accumulator: address,
      owner: address,
      amount: u64,
  ) {
  }

#[ext(spec(target = sui::accumulator::accumulator_address))]
public fun accumulator_address_spec<T>(address: address): address {
    fresh<address>()
}
