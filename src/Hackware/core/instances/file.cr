class Core::File::Instance
  JSON.mapping(
    # if no model, its a generic file not created by the game
    model: String?,
    path: String,
    permissions: String,
    content: String,
  )
end
