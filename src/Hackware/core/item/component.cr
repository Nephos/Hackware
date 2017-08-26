class Core::ItemJSON::Component
  alias Id = UInt32
  include Core::ItemJSON
  JSON.mapping(
    id: Id,
    model: String,
    machine_name: String?,
  )
end

class Core::Item::Component < Core::ItemJSON::Component
  include Core::Item
  extend Core::Item::FromJSON
  getter model_ref : Core::Model::Component
  getter owner : Owner::Person

  def plug(machine : Core::Item::Machine, mods : Mods)
    hook = (activity.hooks["install"]?)
    hook.exec(mods, self, machine.id) unless hook.nil?
  end

  #############################################################################

  RuntimeCall.extends do
    getter_runtime_call(
      "owner"
    )

    define_runtime_call "is_attached_to", String do |args|
      @machine_name == args[0]
    end
  end
end
