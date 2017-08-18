require "./instance_json"

module Core::Instance
  include Core::InstanceJSON
  abstract def model_ref : Model
  # abstract def initialize(jpp : JSON::PullParser, models : Array(Core::Model))
end

module Core::Instance::FromJSON
  def from_json(io_or_string, models : Array(Core::Model))
    parser = JSON::PullParser.new io_or_string
    new parser, models
  end

  macro extended
    def initialize(jpp : JSON::PullParser, models : Array(Core::Model))
      super(jpp)
      @model_ref = models.find { |current_model| @model == current_model.name } || raise "error"
    end
  end
end
