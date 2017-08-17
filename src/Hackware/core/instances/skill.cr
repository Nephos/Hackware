class Core::Skill::InstanceJSON < Core::Instance
  JSON.mapping(
    id: UInt32,
    model: String,
    level: UInt32,
    xp: Float64,
  )
end

class Core::Skill::Instance < Core::Skill::InstanceJSON
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end
