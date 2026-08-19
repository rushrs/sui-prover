// borrow_or_unknown returns the element at index `i` if in range, otherwise
// an uninterpreted value. Unlike vector::borrow, it never aborts in specs.

#[allow(unused)]
module 0x42::vector_ext_borrow_or_unknown_ok;

#[ext(spec_only)]
use prover::prover::{ensures, requires};

#[ext(spec_only)]
use prover::vector_ext::borrow_or_unknown;
#[ext(spec_only)]
use fun prover::vector_ext::borrow_or_unknown as vector.borrow_or_unknown;

// In-range: borrow_or_unknown agrees with vector::borrow.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_in_range_matches_borrow(v: &vector<u64>, i: u64) {
    requires(i < vector::length(v));
    ensures(borrow_or_unknown(v, i) == vector::borrow(v, i));
}

// Method syntax via local `use fun` alias.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_method_syntax(v: &vector<u64>, i: u64) {
    requires(i < vector::length(v));
    ensures(v.borrow_or_unknown(i) == vector::borrow(v, i));
}

// Concrete value read.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_concrete_in_range() {
    let v = vector[10u64, 20, 30];
    ensures(*borrow_or_unknown(&v, 0) == 10);
    ensures(*borrow_or_unknown(&v, 1) == 20);
    ensures(*borrow_or_unknown(&v, 2) == 30);
}
