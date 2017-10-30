require "duktape"

class Array(T)
  # Build an array from the Duktape sandbox stack (arguments of js function, ...)
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
      {{raise "IMPOSSIBLE TO BUILD SUCH ARRAY"}}
    {% end %}
    n = env.get_length idx
    Array(T).new(n) do |index|
      env.get_prop_index idx, index.to_u32
      v = {% if T == Int32 %}
            env.to_int(-1).to_i32
          {% elsif T == Float64 %}
              env.to_number(-1).to_f64
          {% else %}
            env.to_string(-1)
          {% end %}
      env.pop
      v
    end
  end

  # Push the array to the stack of Duktape sandbox (return of js function, ...)
  #
  # ```
  # ["foo", "bar"].push env
  # env.call_success
  # ```
  def push(env : Duktape::Sandbox)
    arr_idx = env.push_array
    self.each_with_index do |v, i|
      {% if {Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64}.includes? T %}
        env.push_int v
      {% elsif {Float32, Float64}.includes? T %}
        env.push_number v
      {% else %}
        env.push_string v.to_s
      {% end %}
      env.put_prop_index arr_idx, i.to_u32
    end
  end
end
