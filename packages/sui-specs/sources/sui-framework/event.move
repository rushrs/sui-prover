#[ext(spec_only)]
module specs::event_spec;

#[ext(spec(target = sui::event::emit))]
public fun emit_spec<T: copy + drop>(event: T) {
}
