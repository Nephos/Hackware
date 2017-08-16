require "./component"

class Core::Machine
  YAML.mapping(
    name: String,
    type: String,
    components: Hash(String, Component?),
    attributes: Hash(String, Float64),
  )
end
