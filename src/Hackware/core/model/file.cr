class Core::Model::File
  include Core::Model
  JSON.mapping(
    name: String,
    content: String,
    type: String,
  )

  RuntimeCall.extends do
    getter_runtime_call(
      "name", "content", "type"
    )
  end
end
