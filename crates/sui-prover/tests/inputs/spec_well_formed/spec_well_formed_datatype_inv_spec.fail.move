module 0x42::bad_inv;

public struct S { x: u8 }

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)] #[allow(unused_function)]
fun S_inv(self: &S): bool {
    self.get_y() > 0
}

public fun get_y(self: &S): u8 {
    get_x(self)
}

public fun get_x(self: &S): u8 {
    self.x
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun get_x_spec(self: &S): u8 {
    get_x(self)
}

#[ext(spec(prove))] #[allow(unused_function, unused)]
fun test(self: &S) {
    ensures(false);
}
