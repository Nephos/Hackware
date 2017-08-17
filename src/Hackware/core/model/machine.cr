require "./component"

class Core::Model::Machine
  JSON.mapping(
    name: String,
    type: String,
    slots: Array(String),
    attributes: Hash(String, Float64),
  )
end
