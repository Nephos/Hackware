require "./component"

class Core::Machine
  JSON.mapping(
    name: String,
    type: String,
    components: Hash(String, Component?),
    attributes: Hash(String, Float64),
    id: UInt32,
  )
end
