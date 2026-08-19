module specs::string_spec;

use prover::prover::fresh;

#[ext(spec(target = std::string::internal_check_utf8))]
public fun internal_check_utf8_spec(v: &vector<u8>): bool {
    fresh<bool>()
}

#[ext(spec(target = std::string::internal_is_char_boundary))]
public fun internal_is_char_boundary_spec(v: &vector<u8>, i: u64): bool {
    fresh<bool>()
}

#[ext(spec(target = std::string::internal_sub_string))]
public fun internal_sub_string_spec(v: &vector<u8>, i: u64, j: u64): vector<u8> {
    fresh<vector<u8>>()
}

#[ext(spec(target = std::string::internal_index_of))]
public fun internal_index_of_spec(v: &vector<u8>, r: &vector<u8>): u64 {
    fresh<u64>()
}
