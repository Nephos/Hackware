require "duktape"

# sbx = Duktape::Sandbox.new
#
# # Push a global function named "add_together"
# # that accepts two arguments.
# sbx.push_global_proc("list_devices", 1) do |ptr|
#  env = Duktape::Sandbox.new ptr
#
#  # Get the two arguments
#  # from the stack
#  api = env.require_string 0
#
#  env.push_string "[stuff, ...]" # Push the return value to the stack
#  env.call_success               # call_success -> stack top is value returned
# end
#
# sbx.eval! "print(list_devices(\"player\"));" # => 5
# puts "Eval = ", sbx.eval("list_devices(\"player\")")
# pp sbx.pop
