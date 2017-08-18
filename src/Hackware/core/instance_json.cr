module Core::InstanceJSON
  abstract def to_json
  abstract def id : UInt32
  abstract def model
end
