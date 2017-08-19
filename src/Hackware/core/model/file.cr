class Core::Model::File
  include Core::Model
  JSON.mapping(
    name: String,
    content: String,
    type: String,
  )

  Core::Terminal.__set_operators(
    "name", "content", "type"
  )

  Core::Terminal.__define_read_operators(
    "name", "content", "type"
  )
end
