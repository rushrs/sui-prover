module std::type_name_spec {
  use std::type_name;
  use std::ascii::String;

  #[ext(spec(prove))]
  fun is_primitive_spec(self: &type_name::TypeName): bool {
    let result = self.is_primitive();
    result
  }

  #[ext(spec(prove))]
  fun as_string_spec(self: &type_name::TypeName): &String {
    let result = self.as_string();
    result
  }

  #[ext(spec(prove))]
  fun address_string_spec(self: &type_name::TypeName): String {
    let result = self.address_string();
    result
  }

  #[ext(spec(prove))]
  fun module_string_spec(self: &type_name::TypeName): String {
    let result = self.module_string();
    result
  }

  #[ext(spec(prove))]
  fun into_string_spec(self: type_name::TypeName): String {
    let result = self.into_string();
    result
  }

  #[ext(spec(prove))]
  fun get_spec<T>(): type_name::TypeName {
    let result = type_name::get<T>();
    result
  }

  #[ext(spec(prove))]
  fun get_with_original_ids_spec<T>(): type_name::TypeName {
    let result = type_name::get_with_original_ids<T>();
    result
  }

  #[ext(spec(prove))]
  fun borrow_string_spec(self: &type_name::TypeName): &String {
    let result = self.borrow_string();
    result
  }

  #[ext(spec(prove))]
  fun get_address_spec(self: &type_name::TypeName): String {
    let result = self.get_address();
    result
  }

  #[ext(spec(prove))]
  fun get_module_spec(self: &type_name::TypeName): String {
    let result = self.get_module();
    result
  }
}
