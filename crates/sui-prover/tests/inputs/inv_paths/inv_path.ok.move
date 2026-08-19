module 0x42::inv_path_foo {
    public struct Bar {
        x: u64
    }

    public fun set_value(bar: &mut Bar, value: u64) {
        bar.x = value;
    }

    public fun get_values(bar: &Bar): u64 {
        bar.x
    }

    public fun increment(bar: &mut Bar) {
        bar.set_value(150);
    }
}

module 0x43::inv_path_foo_spec {
    #[ext(spec_only)]
    use 0x42::inv_path_foo::{increment, Bar};

    #[ext(spec_only(inv_target = 0x42::inv_path_foo::Bar))] #[allow(unused_function)]
    fun foo(bar: &Bar): bool {
        bar.get_values() < 150
    }

    #[ext(spec(prove, target = 0x42::inv_path_foo::increment))] #[allow(unused_function)]
    public fun increment_spec(bar: &mut Bar) {
        bar.increment();
    }
}