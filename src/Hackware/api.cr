require "./api/*"

# require "duktape"
#
# class Array(T)
#
#   CONVERT = {Int8: :to_i8, Int16: :to_i16, Int32: :to_i32, Int64: :to_i64, UInt8: :to_u8, UInt16: :to_u16, UInt32: :to_u32, UInt64: :to_u64, Float32: :to_f32, Float64: :to_f64, String: :to_s}
#
#   # Build an array from the Duktape sandbox stack (arguments of js function, ...)
#   #
#   # ```
#   # data1 = Array(Int32).build(env, 0)
#   # data2 = Array(String).build(env, 1)
#   # ```
#   #
#   # TODO: add boolean
#   # TODO: test with Int64
#   # TODO: add double (number)
#   def self.build(env : Duktape::Sandbox, idx : Int32)
#     n = env.get_length idx
#     Array(T).new(n) do |index|
#       env.get_prop_index idx, index.to_u32
#       v = {% if T == Int32 %}
#             env.to_int(-1).to_i32
#           {% elsif T == Float64 %}
#               env.to_number(-1).to_f64
#           {% else %}
#             env.to_string(-1)
#           {% end %}
#       env.pop
#       v
#     end
#   end
#
#   # Push the array to the stack of Duktape sandbox (return of js function, ...)
#   #
#   # ```
#   # ["foo", "bar"].push env
#   # env.call_success
#   # ```
#   def push(env : Duktape::Sandbox)
#     arr_idx = env.push_array
#     self.each_with_index do |v, i|
#       {% if {Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64}.includes? T %}
#         env.push_int v
#       {% elsif {Float32, Float64}.includes? T %}
#         env.push_number v
#       {% else %}
#         env.push_string v.to_s
#       {% end %}
#       env.put_prop_index arr_idx, i.to_u32
#     end
#   end
# end
#
# USERS = {
#   "arthur"  => [1, 2, 3],
#   "thibaut" => [4, 5, 6.0],
# }

# sbx = Duktape::Sandbox.new
#
# sbx << [777, "4.0", [666], "ok"]
# data = DuktapeBuild::Array.build(sbx, 0)
# puts data
#
# sbx << { "key1" => "data", "key2" => "data2" }
# data = DuktapeBuild::Hash.build(sbx, 0)
# puts data
#
# MY_DATA = { "a" => "Bonjour"}
# my_data = MY_DATA
#
# ApiBuild.create_function(sbx, "my_function", :name, :age) do |ctx, args|
#   # create_function is a macro, so ctx and args are macro arguments
#   puts "=>", {{ctx}}, {{args}}
#   puts MY_DATA["a"]
# end
# sbx.eval "print(my_function)"
# sbx.eval "print(my_function(\"a\", 1))"

#
# sbx << [1, 2]
#
# idx = sbx.push_object
# sbx.push_string "HackwareString"
# sbx.put_prop_string idx, "HackwareKey"
# sbx.put_global_string "Hackware"
# sbx.eval "print(Hackware.HackwareKey)"
#
# VARIABLE = [1,2,3]
# sbx.push_global_proc("list_machines", 2) do |ptr|
#  env = Duktape::Sandbox.new ptr
#  user = env.require_string 0
#  env << VARIABLE
#  env.call_success
# end
#
# sbx.eval! "print(list_machines(\"arthur\", [1,2,3.1]));" # => 5
# #
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
