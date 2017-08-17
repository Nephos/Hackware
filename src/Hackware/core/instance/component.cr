class Core::InstanceJSON::Component < Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    model: String,
    machine_name: String?,
  )
end

class Core::Instance::Component < Core::InstanceJSON::Component
  getter model_ref : Component

  def initialize(jpp : JSON::PullParser)
    super(jpp)
    @model_ref = models.find { |current_model| @model == current_model.name }
  end
end
