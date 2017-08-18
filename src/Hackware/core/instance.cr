require "./instance_json"

module Core::Instance
  include Core::InstanceJSON
  abstract def model_ref
end
