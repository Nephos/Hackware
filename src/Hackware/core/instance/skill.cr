class Core::InstanceJSON::Skill
  include Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    model: String,
    level: UInt32,
    xp: Float64,
  )
end

class Core::Instance::Skill < Core::InstanceJSON::Skill
  # include Core::Instance
  # extend Core::Instance::FromJSON
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end