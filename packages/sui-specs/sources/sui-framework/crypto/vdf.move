module specs::vdf_spec;

use prover::prover::fresh;

#[ext(spec(target = sui::vdf::hash_to_input_internal))]
public fun hash_to_input_internal_spec(message: &vector<u8>): vector<u8> {
    fresh<vector<u8>>()
}

#[ext(spec(target = sui::vdf::vdf_verify_internal))]
public fun vdf_verify_internal_spec(
    input: &vector<u8>,
    output: &vector<u8>,
    proof: &vector<u8>,
    iterations: u64,
  ): bool {
    fresh<bool>()
}
