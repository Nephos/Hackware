require "./resolvable"
require "./terminal"

module Core::Traversable
  include Core::Resolvable
  include Core::Terminal

  # ```
  # arg1, arg2 = __require_arguments("my_function", UInt32, String)
  # ```
  macro __require_arguments(context, values, *_types)
    raise "Invalid argument count in (#{{{context}}}) with arguments (#{{{values}}})" if {{values}}.size != {{_types.size}}
    {
      {% for _i in 0..._types.size %}
        (
          begin
            {{_types[_i]}}.new({{values}}[{{_i}}])
          rescue err
            raise "Invalid (#{{{_i}}}th) argument (#{{{values}}[{{_i}}]}) in (#{{{context}}})"
          end
          ),
      {% end %}
    }
  end

  macro __require_no_arguments(context, values)
    raise "Invalid argument count in (#{{{context}}}) with arguments (#{{{values}}})" unless {{values}}.empty?
  end
end
