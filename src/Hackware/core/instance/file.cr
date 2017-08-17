class Core::File::InstanceJSON < Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    # if no model, its a generic file not created by the game
    model: String?,
    path: String,
    permissions: String,
    content: String,
  )
end

class Core::File::Instance < Core::File::InstanceJSON
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end
