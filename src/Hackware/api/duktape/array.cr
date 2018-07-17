require "duktape"

class Array(T)
  # Build an array from the Duktape sandbox stack (arguments of js function, ...)
  #
  # @param idx the parameter index in the stack
  #
  # ```
  # data1 = Array(Int32).build(env, 0)
  # data2 = Array(String).build(env, 1)
  # ```
  #
  # TODO: add boolean
  # TODO: test with Int64
  # TODO: add double (number)
  def self.build(env : Duktape::Sandbox, idx : Int32)
    {% unless T == Int32 || T == Float64 || T == String %}
      {{ raise "IMPOSSIBLE TO BUILD SUCH ARRAY" }}
    {% end %}

    array_length = env.get_length idx

    Array(T).new(array_length) do |index|
      env.get_prop_index idx, index.to_u32

      current_value =
      {% if T == Int32 %}
        env.to_int(-1).to_i32
      {% elsif T == Float64 %}
        env.to_number(-1).to_f64
      {% else %}
        env.to_string(-1)
      {% end %}

      env.pop
      current_value
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
