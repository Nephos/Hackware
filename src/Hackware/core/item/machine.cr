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

  Core::Resolvable.__set_paths(
    "owner",
  )

  Core::Terminal.__set_operators(
    "name_is",
  )

  # arguments:
  #   - name: String
  def name_is(values)
    args = __require_arguments("name_is", values, String)
    @name == args[0]
  end
end
