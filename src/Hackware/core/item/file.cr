class Core::ItemJSON::File
  alias Id = UInt32
  include Core::ItemJSON
  JSON.mapping(
    id: Id,
    # if no model, its a generic file not created by the game
    model: String?,
    path: String,
    permissions: String,
  )
end

class Core::Item::File < Core::ItemJSON::File
  include Core::Item
  extend Core::Item::FromJSON
  getter model_ref : Core::Model::File
  getter owner : Game::Person

  #############################################################################

  Core::Resolvable.__set_paths(
    "owner",
  )

  def termine(operator : String, values : Array(String)) : Bool
    false
  end
end
