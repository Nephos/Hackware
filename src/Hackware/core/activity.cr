require "./hook"

class Core::Activity
  YAML.mapping(
    name: String,
    duration: Int32,
    requirements: Array(Requirement),
    attributes_usage: Hash(String, Float64),
    hooks: Array(Hook),
  )
end
