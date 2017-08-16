require "./requirement"

class Component
  YAML.mapping(
    name: String,
    attributes: Hash(String, Float64),
    slots: Array(String),
    requirements: Array(Requirement),
  )
end
