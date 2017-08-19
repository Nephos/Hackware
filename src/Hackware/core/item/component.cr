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
  getter owner : Game::Person

  def plug(machine : Core::Item::Machine, mods : Mods)
    hook = (activity.hooks["install"]?)
    hook.exec(mods, self, machine.id) unless hook.nil?
  end

  #############################################################################

  Core::Resolvable.__set_paths(
    "owner",
  )

  Core::Terminal.__set_operators(
    "is_attached_to",
  )

  # arguments:
  #   - id: UInt32
  def is_attached_to(values)
    args = __require_arguments("is_attached_to", values, String)
    return @machine_name == args[0]
  end
end
