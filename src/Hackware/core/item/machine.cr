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
  getter owner : Owner::Person

  #############################################################################

  RuntimeCall.extends do
    getter_runtime_call(
      "owner"
    )

    define_runtime_call "name_is", String do |args|
      @name == args[0]
    end
  end
end
