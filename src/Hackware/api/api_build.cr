require "duktape"
require "./duktape_lib"

module ApiBuild
  include DuktapeBuild::Cast
  extend DuktapeBuild::Cast

  macro read_js_args(ctx, *args)
    %values = Array(DuktapeBuild::Any).new({{args.size}})  do |idx|
      DuktapeBuild::Cast.get_current_value(ctx, idx)
    end
    %keys = {% if args.size > 0 %}
      {{args}}.to_a
    {% else %}
      Array(String).new
    {% end %}
    %js_args = Hash.zip(%keys, %values)
    %js_args
  end

  extend self
end
