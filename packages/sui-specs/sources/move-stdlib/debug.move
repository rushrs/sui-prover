module specs::debug_spec;

use std::debug::{print, print_stack_trace};

#[ext(spec(target = std::debug::print))]
public fun print_spec<T>(x: &T) {
    print(x)
}

#[ext(spec(target = std::debug::print_stack_trace))]
public fun print_stack_trace_spec() {
    print_stack_trace()
}
