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
    n = env.get_length idx
    Array(T).new(n) do |index|
      env.get_prop_index idx, index.to_u32
      v = {% if {Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64}.includes? T %}
            env.to_int -1
          {% else %}
            env.to_string -1
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
      {% else %}
        env.push_string v
      {% end %}
      env.put_prop_index arr_idx, i.to_u32
    end
  end
end

USERS = {
  "arthur"  => [1, 2, 3],
  "thibaut" => [4, 5, 6],
}

sbx = Duktape::Sandbox.new

sbx.push_global_proc("list_machines", 2) do |ptr|
  env = Duktape::Sandbox.new ptr
  user = env.require_string 0
  data = Array(Int32).build(env, 1)
  data.push env
  env.call_success
end

sbx.eval! "print(list_machines(\"arthur\", [1,2,3]));" # => 5

# sbx.push_global_proc("list_machines", 1) do |ptr|
#  env = Duktape::Sandbox.new ptr
#
#  # Get the two arguments from the stack
#  user = env.require_string 0
#  #user = env.require_string 1
#
#  # Get the machines of the user at the IP passed as a parameter
#  user_machines = users.find { |current_user, _| user == current_user } || nil
#
#  if user_machines
#    env.push_string user_machines.inspect # Push the return value to the stack
#    env.call_success               # call_success -> stack top is value returned
#  else
#    env.call_failure
#  end
# end
#
# #owner = Owner::Person.new(0) ### NEED GAMEWORLD WHICH CONTAINS LIST OF MACHINES ETC
# sbx.eval! "print(list_machines(\"arthur\");"
# puts "Eval = ", sbx.eval("list_machines(\"arthur\")")
# pp sbx.pop
