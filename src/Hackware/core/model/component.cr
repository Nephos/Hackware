class Core::Model::Component
  include Core::Model
  JSON.mapping(
    name: String,
    attributes: Hash(String, Float64),
    slots: Array(String),
    requirements: Array(Requirement),
  )
end
