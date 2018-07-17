require "duktape"

class Array::DuktapeBuild
  BUILD = {
    is_number: -> (env : Duktape::Sandbox, index : Int32) {
      value = env.get_number(index)
      value.round == value ? value.to_i32 : value
    },
    is_string: -> (env : Duktape::Sandbox, index : Int32) { env.get_string(index) },
    is_null: -> (env : Duktape::Sandbox, index : Int32) { nil },
    is_boolean: -> (env : Duktape::Sandbox, index : Int32) { env.get_boolean(index) },
    is_array: -> (env : Duktape::Sandbox, index : Int32) {
      DuktapeBuild.build(env, index)
    },
    is_object: -> (env : Duktape::Sandbox, index : Int32) { nil },
  }

  alias Any = Nil | Bool | String | Int::Signed | Int::Unsigned | Float64 | Float32 | Array(Any) | Hash(String, Any)

  def self.cast_to_any(x :  Array)
    return x.map { |e| cast_to_any(e).as(Any) }.as(Any)
  end

  def self.cast_to_any(x : Hash)
    h = Hash(String, Any).new
    x.each do |(k, v)|
      h[k] = cast_to_any(v).as(Any)
    end
    h.as(Any)
  end

  def self.cast_to_any(x)
    x.as(Any)
  end

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

    Array(Any).new(array_length) do |array_idx|
      env.get_prop_index idx, array_idx.to_u32
      begin
        current_value = get_current_value(env)
        cast_to_any(current_value)
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
