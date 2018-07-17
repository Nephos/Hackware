require "./component"

class Core::Model::Machine
  include Core::Model
  JSON.mapping(
    name: String,
    type: String,
    slots: Hash(String, UInt32),
    attributes: Hash(String, Float64),
  )

  RuntimeCall.extends do
    getter_runtime_call(
      "name", "type", "slots", "attributes"
    )
  end
end
