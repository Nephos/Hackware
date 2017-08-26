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
  getter owner : Owner::Person

  #############################################################################

  RuntimeCall.extends do
    getter_runtime_call(
      "owner"
    )

    define_runtime_call "executable" do
      permissions.includes? "x"
    end

    define_runtime_call "is_writable" do
      permissions.includes? "w"
    end

    define_runtime_call "is_readable" do
      permissions.includes? "r"
    end
  end
end
