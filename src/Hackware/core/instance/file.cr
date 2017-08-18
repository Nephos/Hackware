class Core::InstanceJSON::File
  include Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    # if no model, its a generic file not created by the game
    model: String?,
    path: String,
    permissions: String,
    content: String,
  )
end

class Core::Instance::File < Core::InstanceJSON::File
  include Core::Instance
  extend Core::Instance::FromJSON
  getter model_ref : Core::Model::File
end
