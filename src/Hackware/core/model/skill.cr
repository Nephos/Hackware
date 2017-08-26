class Core::Model::Skill
  include Core::Model
  JSON.mapping(
    name: String,
  )

  RuntimeCall.extends do
    getter_runtime_call(
      "name"
    )
  end
end
