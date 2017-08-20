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

  Core::Resolvable.__define_read_paths(
    "owner"
  )

  Core::Terminal.__set_operators(
    "is_executable",
    "is_writable",
    "is_readable",
  )

  Core::Terminal.__define_operator "executable" do
    permissions.includes? "x"
  end

  Core::Terminal.__define_operator "is_writable" do
    permissions.includes? "w"
  end

  Core::Terminal.__define_operator "is_readable" do
    permissions.includes? "r"
  end
end
