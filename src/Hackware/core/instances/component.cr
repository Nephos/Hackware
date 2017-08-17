class Core::Component::InstanceJSON < Core::Instance
  JSON.mapping(
    id: UInt32,
    model: String,
    machine_name: String?,
  )
end

class Core::Component::Instance < Core::Component::InstanceJSON
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end
