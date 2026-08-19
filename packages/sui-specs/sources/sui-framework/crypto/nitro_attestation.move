module specs::nitro_attestation_spec;

use prover::prover::fresh;
use sui::nitro_attestation::NitroAttestationDocument;

#[ext(spec(target = sui::nitro_attestation::load_nitro_attestation_internal))]
public fun load_nitro_attestation_internal_spec(
    attestation: &vector<u8>,
    current_timestamp: u64,
  ): NitroAttestationDocument {
    fresh<NitroAttestationDocument>()
}
