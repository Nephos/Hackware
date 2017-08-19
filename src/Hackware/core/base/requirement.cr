class Core::Requirement
  # `type`.operator(*value)
  #
  # Example (self = Component):
  #   {path: "self.machine.components", operator: "includes?", ["stuff"]}
  # Example (self = Skill)
  #   {path: "self.player.skills", operator: ">=", ["hacking", "3"] }
  JSON.mapping(
    path: String,
    operator: String,
    value: Array(String),
  )

  # TODO
  def exec(context : Core::Item) : Bool
    false
  end

  def resolve_path(context)
    nil
  end
end
