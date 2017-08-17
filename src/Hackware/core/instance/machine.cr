class Core::InstanceJSON::Machine
  include Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    model: String,
    name: String,
  )
end

class Core::Instance::Machine < Core::InstanceJSON::Machine
  # include Core::Instance
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end
