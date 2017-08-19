module Core::ItemJSON
  abstract def to_json
  abstract def id : UInt32
  abstract def model
end
