require "./component"

class Core::Model::Machine
  include Core::Model
  JSON.mapping(
    name: String,
    type: String,
    slots: Array(String),
    attributes: Hash(String, Float64),
  )

  Core::Terminal.__set_operators(
    "name", "type", "slots", "attributes"
  )

  Core::Terminal.__define_read_operators(
    "name", "type", "slots", "attributes"
  )
end
