class Core::Model::File
  include Core::Model
  JSON.mapping(
    name: String,
    content: String,
    type: String,
  )

  def termine(operator : String, values : Array(String)) : Comp
    false
  end
end
