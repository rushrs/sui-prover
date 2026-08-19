module 0x42::foo_specs;
#[ext(spec_only)]
use prover::prover::ensures;
#[ext(spec_only)]
use prover::ghost;
#[ext(spec_only)]
use sui::transfer::public_transfer;

public struct Foo has key, store {
  id: UID
}

public struct CustomGlobal {}

#[ext(spec(target = sui::transfer::public_transfer))] #[allow(unused_function)]
fun public_transfer_spec<T: key + store>(obj: T, recipient: address) {
  ghost::declare_global_mut<CustomGlobal, bool>();
  public_transfer(obj, recipient);
  ensures(ghost::global<CustomGlobal, bool>() == true);
}

public fun foo(obj: Foo, recipient: address) {
  public_transfer(obj, recipient);
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(obj: Foo, recipient: address) {
  ghost::declare_global_mut<CustomGlobal, bool>();
  foo(obj, recipient);
  ensures(ghost::global<CustomGlobal, bool>() == true);
}

// Should not fail because we overrided system spec
