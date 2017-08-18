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

  def initialize(jpp : JSON::PullParser, models : Array(Core::Model))
    super(jpp)
    @model_ref = models.find { |current_model| @model == current_model.name } || raise "error"
  end

  def self.from_json(io_or_string, models : Array(Core::Model))
    parser = JSON::PullParser.new io_or_string
    new(parser, models)
  end
end
