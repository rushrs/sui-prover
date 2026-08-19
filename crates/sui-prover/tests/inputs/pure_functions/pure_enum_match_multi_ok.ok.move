module 0x42::pure_enum_match_multi;

#[ext(spec_only)]
use prover::prover::ensures;

public enum Tag has copy, drop {
    Alpha,
    Beta(u8),
    Gamma(u8, u8),
    Delta,
}

#[ext(pure)]
public fun first_byte(t: Tag): u8 {
    match (t) {
        Tag::Alpha => 0,
        Tag::Beta(b) => b,
        Tag::Gamma(b, _) => b,
        Tag::Delta => 255,
    }
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_alpha() {
    ensures(first_byte(Tag::Alpha) == 0)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_beta() {
    ensures(first_byte(Tag::Beta(42)) == 42)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_gamma() {
    ensures(first_byte(Tag::Gamma(7, 9)) == 7)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_delta() {
    ensures(first_byte(Tag::Delta) == 255)
}
