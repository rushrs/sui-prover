module 0x42::foo;

use prover::prover::ensures;
use prover::ghost;

public struct GhostStruct {}

#[ext(spec(prove))] #[allow(unused_function)]
fun ghost_borrow_mut_spec() {
  ghost::declare_global_mut<GhostStruct, bool>();
  let ghost_ref = ghost::borrow_mut<GhostStruct, bool>();
  ghost::set<GhostStruct, bool>(&true);
  *ghost_ref = false;
  ensures(ghost::global<GhostStruct, bool>() == true);
}
