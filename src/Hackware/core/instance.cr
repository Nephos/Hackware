require "./instance_json"

module Core::Instance
  include Core::InstanceJSON
  abstract def model_ref
#  abstract def initialize(jpp : JSON::PullParser, models : Array(Core::Model))
end
