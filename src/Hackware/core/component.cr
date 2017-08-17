require "./requirement"

class Core::Component
  JSON.mapping(
    name: String,
    attributes: Hash(String, Float64),
    slots: Array(String),
    requirements: Array(Requirement),
    machine: UInt32?,
    id: UInt32,
  )
end
