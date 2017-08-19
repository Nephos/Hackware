class Core::InstanceJSON::Machine
  alias Id = UInt32
  include Core::InstanceJSON
  JSON.mapping(
    id: Id,
    model: String,
    name: String,
  )
end

class Core::Instance::Machine < Core::InstanceJSON::Machine
  include Core::Instance
  extend Core::Instance::FromJSON
  getter model_ref : Core::Model::Machine
  getter owner : Game::Person
end
