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
  extend Core::Instance::FromJson
  getter model_ref : Core::Model::Component
end
