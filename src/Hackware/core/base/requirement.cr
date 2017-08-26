require "./resolvable"

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

  # Return true or false given if the requirement is fulfilled or not.
  #
  # ```
  # requirement = Requirement.from_json %({"path": "self.end", "operator": "is_eq", "values": ["1"]})
  # requirement.resolve_value(self_item) # => true/false
  # ```
  def resolve_value(context : RuntimeCall::IReturnable) : Bool
    !!resolve_path(context).termine(self.operator, self.values)
  end

  # Much like resolve_value but only get the last object on which
  # the terminal operator can be applied.
  #
  # ```
  # requirement = Requirement.from_json %({"path": "self.end", "operator": "is_eq", "values": ["1"]})
  # requirement.resolve_path(self_item) # => self_item.end (no exactly, but the iead is here)
  # ```
  def resolve_path(context : RuntimeCall::IReturnable) : RuntimeCall::IReturnable
    context.resolve_path(self.path.split("."))
  end
end
