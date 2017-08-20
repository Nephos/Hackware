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

  Core::Resolvable.__define_read_paths(
    "owner"
  )

  Core::Terminal.__set_operators(
    "name_is",
  )

  Core::Terminal.__define_operator "name_is", String do |args|
    @name == args[0]
  end
end
