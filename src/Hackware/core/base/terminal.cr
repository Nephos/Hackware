require "./resolvable"

module Core::Terminal
  abstract def termine(operator : String, values : Array(String)) : Bool

  macro __set_operators(*operators)
    TERMINE_OPERATORS = {
      {% for op in operators %}
        {{op}} => -> (terminal : self.class, args : Array(String)) { terminal.{{op.id}}(args) },
      {% end %}
    }
  end

  macro __get_operator(operator)
    TERMINE_OPERATORS[operator]?
  end

  module AndResolvable
    include Core::Terminal
    include Core::Terminal
  end
end
