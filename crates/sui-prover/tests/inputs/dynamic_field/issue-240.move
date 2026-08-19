module 0x42::foo;

use prover::prover::asserts;

use std::string::String;
use sui::dynamic_field;

public struct Foo has key {
    id: UID,
}

public fun borrow_uid(foo: &Foo): &UID {
    &foo.id
}

public fun foo(foo: &Foo, key: String): bool {
    *dynamic_field::borrow<String, u64>(&foo.id, key) == 10
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(foo: &Foo, key: String): bool {
    let id = borrow_uid(foo);
    asserts(dynamic_field::exists_with_type<String, u64>(id, key));
    foo(foo, key)
}
