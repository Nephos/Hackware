class Activity
  YAML.mapping(
    name: String,
    duration: Int32,
    requirements: Array(Requirement),
    attributes_usage: Array(String, Float64),
  )
end
