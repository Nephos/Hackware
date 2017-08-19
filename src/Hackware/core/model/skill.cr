class Core::Model::Skill
  include Core::Model
  JSON.mapping(
    name: String,
  )

  Core::Terminal.__set_operators(
    "name"
  )

  Core::Terminal.__define_read_operators(
    "name"
  )
end
