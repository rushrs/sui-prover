// Tests for the std::vector::append_pure native. Also demonstrates using
// concat in a loop invariant to express the relationship between the already-
// processed prefix and the unprocessed suffix of a source vector.

#[allow(unused)]
module 0x42::quantifiers_concat_ok;

#[ext(spec_only)]
use prover::prover::{ensures, requires, invariant};

#[ext(spec_only)]
use prover::vector_iter::slice;
#[ext(spec_only)]
use prover::vector_ext::append_pure;

// Concrete values: concat of two literal vectors.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_concat_concrete() {
    let v1 = vector[1u64, 2, 3];
    let v2 = vector[4u64, 5];
    ensures(append_pure(&v1, &v2) == vector[1, 2, 3, 4, 5]);
}

// Identity: concat with an empty vector on either side is the other vector.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_concat_empty_left() {
    let empty: vector<u64> = vector[];
    let v = vector[1, 2, 3];
    ensures(append_pure(&empty, &v) == v);
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_concat_empty_right() {
    let v = vector[1, 2, 3];
    let empty: vector<u64> = vector[];
    ensures(append_pure(&v, &empty) == v);
}

// Length additivity.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_concat_length() {
    let v1 = vector[1u64, 2];
    let v2 = vector[3u64, 4, 5];
    let r = append_pure(&v1, &v2);
    ensures(vector::length(r) == vector::length(&v1) + vector::length(&v2));
}

// Splitting a vector into (prefix, suffix) and re-concatenating yields the
// original. Exercises concat in combination with slice.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_concat_of_slices(v: &vector<u64>, i: u64) {
    requires(i <= vector::length(v));
    let prefix = slice(v, 0, i);
    let suffix = slice(v, i, vector::length(v));
    ensures(append_pure(prefix, suffix) == *v);
}

// Loop invariant expressed via concat: the vector built so far plus the
// unprocessed suffix of v equals v. This is the natural shape for a suffix
// invariant over vector-valued operations.
fun copy_vec(v: &vector<u64>): vector<u64> {
    let n = vector::length(v);
    let mut i = 0;
    let mut r = vector[];
    invariant!(|| ensures(
        i <= n
            && vector::length(&r) == i
            && append_pure(&r, slice(v, i, n)) == *v
    ));
    while (i < n) {
        r.push_back(*vector::borrow(v, i));
        i = i + 1;
    };
    r
}

#[ext(spec(prove))] #[allow(unused_function)]
fun copy_vec_spec(v: &vector<u64>): vector<u64> {
    let r = copy_vec(v);
    ensures(r == *v);
    r
}
