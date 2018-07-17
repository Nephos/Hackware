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

  alias Any = Nil | Bool | String | Int::Signed | Int::Unsigned | Float64 | Float32 | ::Array(Any) | ::Hash(String, Any)

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

  def self.get_current_value(env, idx)
    {% for type_check, type_get in BUILD %}
      should_get_value = env.{{ type_check }}(idx)
      if should_get_value
        return ({{ type_get }}).call(env, idx)
      end
    {% end %}
    raise "Value not found"
  end
end
