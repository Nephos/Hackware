class Core::Model::File
  include Core::Model
  JSON.mapping(
    name: String,
    content: String,
    type: String,
  )
end
