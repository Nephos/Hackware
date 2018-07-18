require "duktape"
require "./duktape_lib"

module ApiBuild
  include DuktapeBuild::Cast
  extend DuktapeBuild::Cast

  # @param args is a tuple { name: Type }
  macro create_function(env, name, *args, &block)
    {{env}}.push_global_proc({{name}}, {{args.size}}) do |ptr|
      puts "..."
      context = Duktape::Sandbox.new ptr
      puts "..."
      values = Array(DuktapeBuild::Any).new({{args.size}})  do |idx|
        DuktapeBuild::Cast.get_current_value(context, idx)
      end
      keys = {{args}}.map(&.to_s).to_a

      js_args = Hash.zip(keys, values)
      puts js_args

      {{yield context, js_args}}
      context.call_success
    end
  end

  extend self
end
