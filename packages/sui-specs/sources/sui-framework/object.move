module specs::object_spec;

#[ext(spec(target = sui::object::delete_impl))]
fun delete_impl_spec(id: address) {
}

#[ext(spec(target = sui::object::record_new_uid))]
fun record_new_uid_spec(id: address) {
}
