module 0x42::foo;

use prover::log;
use prover::prover::ensures;

#[allow(unused_variable)]
public fun foo(r: u64): u64 {
    6
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(r: u64): u64 {
    log::text("test log");
    log::var<u64>(&r);
    let res = foo(r);
    ensures(res == 5); // should fail
    res
}
