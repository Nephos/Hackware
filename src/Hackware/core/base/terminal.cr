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
        {{op}} => -> (terminal : self, args : Array(String)) { terminal.{{op.id}}(args) },
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
  macro __define_read_operators(*operators)
    {% for op in operators %}
      def {{op.id}}(values)
        @{{op.id}}
      end
    {% end %}
  end

  class UndefinedOperator < Exception
  end
end
