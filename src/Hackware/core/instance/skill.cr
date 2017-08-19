class Core::InstanceJSON::Skill
  alias Id = UInt32
  include Core::InstanceJSON
  JSON.mapping(
    id: Id,
    model: String,
    level: UInt32,
    xp: Float64,
  )
end

class Core::Instance::Skill < Core::InstanceJSON::Skill
  include Core::Instance
  extend Core::Instance::FromJSON
  getter model_ref : Core::Model::Skill
  getter owner : Game::Person
end
