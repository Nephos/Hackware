# require "duktape"
#
# sbx = Duktape::Sandbox.new
#
# # Push a global function named "list_machines" that accepts one argument: the IP of the user.
# sbx.push_global_proc("list_machines", 2) do |ptr|
#  env = Duktape::Sandbox.new ptr
#
#  # Get the two arguments from the stack
#  api = env.require_string 0
#  user_ip = env.require_string 1
#
#  # Get the machines of the user at the IP passed as a parameter
#  user_machines = "test"# users.find { |current_user| user_ip == current_user.ip } || nil
#
#  if user_machines
#    env.push_string user_machines # Push the return value to the stack
#    env.call_success               # call_success -> stack top is value returned
#  else
#    env.call_failure
#  end
# end
#
# owner = Owner::Person.new(0) ### NEED GAMEWORLD WHICH CONTAINS LIST OF MACHINES ETC
# sbx.eval! "print(list_machines(\"127.0.0.1\"));"
# puts "Eval = ", sbx.eval("list_machines(\"127.0.0.1\")")
# pp sbx.pop
