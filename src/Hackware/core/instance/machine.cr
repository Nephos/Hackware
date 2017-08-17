class Core::InstanceJSON::Machine < Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    model: String,
    name: String,
  )
end

class Core::Instance::Machine < Core::InstanceJSON::Machine
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end
