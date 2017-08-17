class Core::Requirement
  # `type`.operator(*value)
  #
  # Example (self = Component):
  #   {type: "self.machine.components", operator: "includes?", ["stuff"]}
  # Example (self = Skill)
  #   {type: "self.player.skills", operator: ">=", ["hacking", "3"] }
  JSON.mapping(
    name: String?,
    type: String,
    operator: String,
    value: Array(String),
  )

  # TODO
  def exec(context) : Bool
    false
  end
end
