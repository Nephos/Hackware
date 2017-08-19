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

  def resolve(fct : String) : Core::Resolvable
    self
  end

  def termine(operator : String, values : Array(String)) : Bool
    false
  end
end
