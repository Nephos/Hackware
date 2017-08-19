class Core::Model::Skill
  include Core::Model
  JSON.mapping(
    name: String,
  )

  def termine(operator : String, values : Array(String)) : Comp
    false
  end
end
