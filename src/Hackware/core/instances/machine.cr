class Core::Machine::InstanceJSON < Core::Instance
  JSON.mapping(
    id: UInt32,
    model: String,
    name: String,
  )
end

class Core::Machine::Instance < Core::Machine::InstanceJSON
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end
