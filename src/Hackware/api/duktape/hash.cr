require "duktape"

class DuktapeBuild::Hash

  # Build an array from the Duktape sandbox stack (arguments of js function, ...)
  #
  # @param idx the parameter index in the stack
  #
  # ```
  # data1 = Array(Int32).build(env, 0)
  # data2 = Array(String).build(env, 1)
  # ```
  def self.build(env : Duktape::Sandbox, idx : Int32 = 0)
    env.enum idx, 0
    collect = ::Hash(String, Any).new
    while current_idx = env.next -1, true
      begin
        current_key = env.get_string -2
        current_value = DuktapeBuild.get_current_value(env, -1)
        raise "Invalid key" if current_key.nil?
        collect[current_key] = current_value
        DuktapeBuild.cast_to_any(current_value)
      ensure
        env.pop_2
      end
    end
    collect
  end
end

module Duktape::API::Push
  def <<(hash : Hash)
    hash_ptr = self.push_object
    hash.each do |idx, value|
      self << value
      self.put_prop_string hash_ptr, idx.to_s
    end
  end
end
