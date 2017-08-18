require "./component"

class Core::Model::Machine
  include Core::Model
  JSON.mapping(
    name: String,
    type: String,
    slots: Array(String),
    attributes: Hash(String, Float64),
  )
end
