class Core::ItemJSON::Machine
  alias Id = UInt32
  include Core::ItemJSON
  JSON.mapping(
    id: Id,
    model: String,
    name: String,
  )
end

class Core::Item::Machine < Core::ItemJSON::Machine
  include Core::Item
  extend Core::Item::FromJSON
  getter model_ref : Core::Model::Machine
  getter owner : Game::Person

  #############################################################################

  def resolve(fct : String) : Core::Resolvable
    self
  end

  def termine(operator : String, values : Array(String)) : Bool
    false
  end
end