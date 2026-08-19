#[allow(unused)]
module 0x42::extra_bpl_missing;

#[ext(spec_only)]
use prover::prover::ensures;

// This should fail because the file doesn't exist
#[ext(spec(prove, extra_bpl = b"nonexistent.bpl"))] #[allow(unused_function)]
fun test_missing_file_spec() {
    ensures(true);
}
