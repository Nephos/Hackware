require "duktape"

class Array(T)
  BUILD = {
    is_number: -> (env : Duktape::Sandbox, index : Int32) {
      value = env.get_number(index)
      value.round == value ? value.to_i32 : value
    },
    is_string: -> (env : Duktape::Sandbox, index : Int32) { env.get_string(index) },
    is_null: -> (env : Duktape::Sandbox, index : Int32) { nil },
    is_boolean: -> (env : Duktape::Sandbox, index : Int32) { env.get_boolean(index) },
    is_array: -> (env : Duktape::Sandbox, index : Int32) {
      nil # ArrayBuild.build(env, index)
    },
    is_object: -> (env : Duktape::Sandbox, index : Int32) { nil },
  }

  alias ATOM = Int::Signed | Int::Unsigned | Float64 | String | Nil
  alias COMPOSE = ATOM | Array(COMPOSE)
  alias ANY = COMPOSE

  def self.get_current_value(env)
    {% for type_check, type_get in BUILD %}
      should_get_value = env.{{ type_check }}(-1)
      if should_get_value
        return ({{ type_get }}).call(env, -1)
      end
    {% end %}
    raise "Value not found"
  end

  # Build an array from the Duktape sandbox stack (arguments of js function, ...)
  #
  # @param idx the parameter index in the stack
  #
  # ```
  # data1 = Array(Int32).build(env, 0)
  # data2 = Array(String).build(env, 1)
  # ```
  def self.build(env : Duktape::Sandbox, idx : Int32 = 0)
    array_length = env.get_length idx

    Array(T).new(array_length) do |array_idx|
      env.get_prop_index idx, array_idx.to_u32
      begin
        current_value = get_current_value(env)
        current_value.as(T)
      ensure
        env.pop
      end
    end
  end
end

module Duktape::API::Push
  def <<(array : Array)
    array_ptr = self.push_array
    array.each_with_index do |value, idx|
      self << value
      self.put_prop_index array_ptr, idx.to_u32
    end
  end
end
