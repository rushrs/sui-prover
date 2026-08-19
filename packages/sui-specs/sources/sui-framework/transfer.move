module specs::transfer_spec;

#[ext(spec_only)]
use prover::prover::{drop, fresh};
use sui::object::ID;

public struct SpecTransferAddress {}
public struct SpecTransferAddressExists {}

#[ext(spec(target = sui::transfer::freeze_object_impl))]
fun freeze_object_impl_spec<T: key>(obj: T) {
    drop(obj)
}

#[ext(spec(target = sui::transfer::share_object_impl))]
fun share_object_impl_spec<T: key>(obj: T) {
    drop(obj)
}

#[ext(spec(target = sui::transfer::transfer_impl))]
fun transfer_impl_spec<T: key>(obj: T, recipient: address) {
    drop(obj)
}

#[ext(spec(target = sui::transfer::receive_impl))]
fun receive_impl_spec<T: key>(parent: address, to_receive: ID, version: u64): T {
    fresh<T>()
}

#[ext(spec(target = sui::transfer::party_transfer_impl))]
fun party_transfer_impl_spec<T: key>(
    obj: T,
    default_permissions: u64,
    addresses: vector<address>,
    permissions: vector<u64>,
  ) {
    drop(obj)
}
