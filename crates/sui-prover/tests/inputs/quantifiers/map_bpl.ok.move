#[allow(unused)]
module 0x42::quantifiers_map_ok;

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)]
use prover::vector_iter::map;

#[ext(spec_only)] #[allow(unused_function)]
native fun x_plus_10(x: &u64): u64;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_spec() {
    let v = vector[10, 20, 10, 30];
    ensures(map!<u64, u64>(&v, |x| x_plus_10(x)) == vector[20, 30, 20, 40]);
}
