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

  Core::Terminal.__set_operators(
    "is_executable",
    "is_writable",
    "is_readable",
  )

  # arguments: none
  def is_executable(values)
    __require_no_arguments("is_max", values)
    return permissions.includes? "x"
  end

  # arguments: none
  def is_writable(values)
    __require_no_arguments("is_max", values)
    return permissions.includes? "w"
  end

  # arguments: none
  def is_readable(values)
    __require_no_arguments("is_max", values)
    return permissions.includes? "r"
  end
end
