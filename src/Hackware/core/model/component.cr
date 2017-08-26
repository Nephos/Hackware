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

  RuntimeCall.extends do
    getter_runtime_call(
      "name", "attributes", "slots"
    )
  end
end
