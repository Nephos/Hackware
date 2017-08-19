require "./resolvable"

module Core::Terminal
  alias Atom = Int64 | Float64 | String | Bool | Nil
  alias Comp = Array(Comp) | Hash(Comp, Comp) | Atom

  abstract def termine(operator : String, values : Array(String)) : Comp

  # Defines a list of functions that are used to find operator, and defines `termine`.
  #
  # It makes the `termine` able to call the function by associating their name with a proc.
  macro __set_operators(*operators)
    TERMINE_OPERATORS = {
      {% for op in operators %}
        {{op}} => -> (terminal : self.class, args : Array(String)) { terminal.{{op.id}}(args) },
      {% end %}
    }

    # Read into the list of operators functions to call the right one.
    def termine(operator : String, values : Array(String)) : Core::Terminal::Comp
      operator_fct = Core::Terminal.__get_operator(operator)
      raise UndefinedOperator.new %(No terminal operator "#{operator}" in (#{self.class})) if operator_fct.nil?
      operator_fct.call(self, values)
    end
  end

  macro __get_operator(operator)
    TERMINE_OPERATORS[operator]?
  end

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

  class UndefinedOperator < Exception
  end
end
