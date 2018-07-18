module DuktapeBuild
  class Array; end
  class Hash; end

  BUILD = {
    is_number: -> (env : Duktape::Sandbox, index : Int32) {
      value = env.get_number(index)
      value.round == value ? value.to_i32 : value
    },
    is_string: -> (env : Duktape::Sandbox, index : Int32) { env.get_string(index) },
    is_null: -> (env : Duktape::Sandbox, index : Int32) { nil },
    is_boolean: -> (env : Duktape::Sandbox, index : Int32) { env.get_boolean(index) },
    is_array: -> (env : Duktape::Sandbox, index : Int32) {
      DuktapeBuild::Array.build(env, index)
    },
    is_object: -> (env : Duktape::Sandbox, index : Int32) {
      DuktapeBuild::Hash.build(env, index)
    },
  }
end
