require "./resolvable"

module Core::Terminal
  abstract def termine(operator : String, values : Array(String)) : Bool

  macro __set_termine_operators(*operators)
    TERMINE = {
      {% for op in operators %}
        {{op}} => -> (terminal : self.class, args : Array(String)) { terminal.{{op.id}}(args) },
      {% end %}
    }
  end

  module AndResolvable
    include Core::Terminal
    include Core::Terminal
  end
end
