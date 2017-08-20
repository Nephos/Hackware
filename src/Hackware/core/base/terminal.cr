require "./resolvable"

module Core::Terminal
  alias Atom = Int64 | Float64 | String | Bool | Nil
  alias Comp = Array(Comp) | Hash(Comp, Comp) | Atom

  abstract def termine(operator : String, values : Array(String)) : Comp

  # Defines a list of functions that are used to find operator, and defines `termine`.
  #
  # It makes the `termine` able to call the function by associating their name with a proc.
  macro __set_operators(*_operators)
    TERMINE_OPERATORS = {
      {% for _op in _operators %}
        {{_op}} => -> (terminal : self, args : Array(String)) { terminal._t_{{_op.id}}(args) },
      {% end %}
    }

    # Read into the list of operators functions to call the right one.
    def termine(operator : String, values : Array(String)) : Core::Terminal::Comp
      operator_fct = TERMINE_OPERATORS[operator]?
      raise UndefinedOperator.new %(No terminal operator "#{operator}" in (#{self.class})) if operator_fct.nil?
      operator_fct.call(self, values)
    end
  end

  # Defines getter with an unused parameter so it is compatible with the prototype used by __set_operators()
  macro __define_read_operators(*_operators)
    {% for _op in _operators %}
      def _t_{{_op.id}}(values)
        @{{_op.id}}
      end
    {% end %}
  end

  macro __define_operator(_operator, *_types, &_block)
    def _t_{{_operator.id}}(values)
      {% if _types.empty? %}
        Core::Terminal.__require_no_arguments({{_operator}}, values)
        {{yield}}
      {% else %}
        args = Core::Terminal.__require_arguments({{_operator}}, values, {{*_types}})
        {{yield args}}
      {% end %}
    end
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
