require "duktape"

class DuktapeBuild::Array

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

    ::Array(Any).new(array_length) do |array_idx|
      env.get_prop_index idx, array_idx.to_u32
      begin
        current_value = DuktapeBuild.get_current_value(env, -1)
        DuktapeBuild.cast_to_any(current_value)
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
