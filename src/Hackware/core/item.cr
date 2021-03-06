require "./item_json"
require "./base/resolvable"

module Core::Item
  include Core::ItemJSON
  include Core::Resolvable

  abstract def model_ref : Model
  abstract def owner : Owner::Person

  # abstract def initialize(jpp : JSON::PullParser, models : Array(Core::Model))
end

module Core::Item::FromJSON
  def from_json(io_or_string, *args)
    parser = JSON::PullParser.new io_or_string
    new parser, *args
  end

  macro extended
    def initialize(jpp : JSON::PullParser, models : Array(Core::Model), @owner : Owner::Person)
      super(jpp)
      @model_ref = models.find { |current_model| @model == current_model.name } || raise "error finding model"
    end
  end
end
