class Core::File::InstanceJSON
  include Core::InstanceJSON
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
  # include Core::Instance
  def initialize(jpp : JSON::PullParser)
    super(jpp)
  end
end
