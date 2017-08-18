class Core::InstanceJSON::Component
  include Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    model: String,
    machine_name: String?,
  )
end

class Core::Instance::Component < Core::InstanceJSON::Component
  include Core::Instance
  getter model_ref : Core::Model::Component

  def initialize(jpp : JSON::PullParser, models : Array(Core::Model::Component))
    super(jpp)
    @model_ref = models.find { |current_model| @model == current_model.name }
  end
end
