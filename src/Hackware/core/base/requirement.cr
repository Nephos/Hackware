require "./resolvable"
require "./terminal"

class Core::Requirement
  # `type`.operator(*value)
  #
  # Example (self = Skill)
  #   {path: "self.player", operator: "skill_greaters", values: ["hacking", "3"] }
  JSON.mapping(
    path: String,
    operator: String,
    values: Array(String),
  )

  # TODO
  # def exec(context : Core::Item) : Bool
  def resolve_value(context : Core::Terminal::AndResolvable) : Bool
    resolve_path(context).termine(self.operator, self.values)
  end

  def resolve_path(context : Core::Resolvable) : Core::Resolvable
    context.resolve_path(self.path.split("."))
  end
end
