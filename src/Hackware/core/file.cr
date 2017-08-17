class Core::File
  JSON.mapping(
    path: String,
    content: String,
    permissions: Int32,
    type: String,
  )
end
