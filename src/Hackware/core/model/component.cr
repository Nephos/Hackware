class Core::Model::Component
  include Core::Model
  JSON.mapping(
    name: String,
    attributes: Hash(String, Float64),
    slots: Array(String),
    requirements: Array(Requirement),
    # install, uninstall
    hooks: Hash(String, Hook),
  )

  Core::Terminal.__set_operators(
    "name", "attributes", "slots"
  )

  Core::Terminal.__define_read_operators(
    "name", "attributes", "slots"
  )
end
