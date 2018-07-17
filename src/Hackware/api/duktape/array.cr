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

  # Push the array to the stack of Duktape sandbox (return of js function, ...)
  #
  # ```
  # ["foo", "bar"].push env
  # env.call_success
  # ```
  def push(env : Duktape::Sandbox)
    # initialize the array
    array_ptr = env.push_array

    # for each element of the array, push the value
    self.each_with_index do |value, idx|
      {% if {Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64}.includes? T %}
        env.push_int value
      {% elsif {Float32, Float64}.includes? T %}
        env.push_number value
      {% else %}
        env.push_string value.to_s
      {% end %}

      # for the current element, set the index
      env.put_prop_index array_ptr, idx.to_u32
    end
  end
end
