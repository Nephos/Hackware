require "./component"

class Core::Machine
  JSON.mapping(
    name: String,
    type: String,
    slots: Array(String),
    attributes: Hash(String, Float64),
    id: UInt32,
  )
end
