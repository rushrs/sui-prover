module 0x42::foo;

use prover::prover::ensures;
use prover::ghost;

public struct GhostStruct {}

fun foo(ref: &mut bool) {
  *ref = true;
}

#[ext(spec)] #[allow(unused_function)]
fun foo_spec(ref: &mut bool) {
  foo(ref);
  ensures(*ref == true);
}

#[ext(spec(prove))] #[allow(unused_function)]
fun ghost_borrow_mut_spec() {
  ghost::declare_global_mut<GhostStruct, bool>();
  let ghost_ref = ghost::borrow_mut<GhostStruct, bool>();
  foo(ghost_ref);
  ensures(ghost::global<GhostStruct, bool>() == true);
}
