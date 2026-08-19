module 0x42::pure_enum_reordered;

#[ext(spec_only)]
use prover::prover::ensures;

public enum Op has copy, drop {
    Add,
    Sub,
    Mul,
    Neg,
}

// Arms listed in a different order than the variant declarations:
// declaration order is Add, Sub, Mul, Neg; this match uses Mul, Neg, Add, Sub.
#[ext(pure)]
public fun arity(o: Op): u8 {
    match (o) {
        Op::Mul => 2,
        Op::Neg => 1,
        Op::Add => 2,
        Op::Sub => 2,
    }
}

// Reordered with a wildcard for part of the enum.
#[ext(pure)]
public fun is_unary(o: Op): bool {
    match (o) {
        Op::Neg => true,
        _ => false,
    }
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_arity_add() {
    ensures(arity(Op::Add) == 2)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_arity_neg() {
    ensures(arity(Op::Neg) == 1)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_arity_mul() {
    ensures(arity(Op::Mul) == 2)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_arity_sub() {
    ensures(arity(Op::Sub) == 2)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_unary_neg() {
    ensures(is_unary(Op::Neg))
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_unary_add() {
    ensures(!is_unary(Op::Add))
}
