module 0x42::foo;

use prover::ghost;

public fun foo<T>() {}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec<T>() {
    ghost::declare_global_mut<T, bool>();
    ghost::declare_global<u64, bool>();
    foo<T>()
}

public fun bar<T>() {
    foo<T>();
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun bar_spec<T>() {
    ghost::declare_global<T, bool>();
    ghost::declare_global<u64, bool>();
    bar<T>()
}
