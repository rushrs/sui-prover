module specs::groth16_spec;

use prover::prover::fresh;
use sui::groth16::PreparedVerifyingKey;

#[ext(spec(target = sui::groth16::prepare_verifying_key_internal))]
public fun prepare_verifying_key_internal_spec(
    curve: u8,
    verifying_key: &vector<u8>,
  ): PreparedVerifyingKey {
    fresh<PreparedVerifyingKey>()
}

#[ext(spec(target = sui::groth16::verify_groth16_proof_internal))]
public fun verify_groth16_proof_internal_spec(
    curve: u8,
    vk_gamma_abc_g1_bytes: &vector<u8>,
    alpha_g1_beta_g2_bytes: &vector<u8>,
    gamma_g2_neg_pc_bytes: &vector<u8>,
    delta_g2_neg_pc_bytes: &vector<u8>,
    public_proof_inputs: &vector<u8>,
    proof_points: &vector<u8>,
  ): bool {
    fresh<bool>()
}
