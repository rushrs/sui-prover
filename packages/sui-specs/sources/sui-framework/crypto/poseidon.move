module specs::poseidon_spec;

use prover::prover::fresh;

#[ext(spec(target = sui::poseidon::poseidon_bn254_internal))]
public fun poseidon_bn254_internal_spec(data: &vector<vector<u8>>): vector<u8> {
    fresh<vector<u8>>()
}
