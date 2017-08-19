class Core::InstanceJSON::File
  alias Id = UInt32
  include Core::InstanceJSON
  JSON.mapping(
    id: Id,
    # if no model, its a generic file not created by the game
    model: String?,
    path: String,
    permissions: String,
  )
end

class Core::Instance::File < Core::InstanceJSON::File
  include Core::Instance
  extend Core::Instance::FromJSON
  getter model_ref : Core::Model::File
  getter owner : Game::Person
end
