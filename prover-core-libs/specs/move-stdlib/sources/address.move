module std::address_spec {
  use std::address;

  #[ext(spec(prove))]
  fun length_spec(): u64 {
        let result = address::length();
        result
  }
}
