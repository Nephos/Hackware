require "./resolvable"

module Core::Terminal
  abstract def termine(operator : String, values : Array(String)) : Bool

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
    def termine(operator : String, values : Array(String)) : Bool
      operator_fct = Core::Terminal.__get_operator(operator)
      raise UndefinedOperator.new %(No terminal operator "#{operator}" in (#{self.class})) if operator_fct.nil?
      operator_fct.call(self, values)
    end
  end

  macro __get_operator(operator)
    TERMINE_OPERATORS[operator]?
  end

  module AndResolvable
    include Core::Terminal
    include Core::Terminal
  end

  class UndefinedOperator < Exception
  end
end
