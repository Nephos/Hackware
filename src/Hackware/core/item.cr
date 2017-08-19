require "./item_json"

module Core::Item
  include Core::ItemJSON

  abstract def model_ref : Model
  abstract def owner : Game::Person
  # abstract def initialize(jpp : JSON::PullParser, models : Array(Core::Model))
end

module Core::Item::FromJSON
  def from_json(io_or_string, *args)
    parser = JSON::PullParser.new io_or_string
    new parser, *args
  end

  macro extended
    def initialize(jpp : JSON::PullParser, models : Array(Core::Model), @owner : Game::Person)
      super(jpp)
      @model_ref = models.find { |current_model| @model == current_model.name } || raise "error finding model"
    end
  end
end
