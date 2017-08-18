class Core::InstanceJSON::Component
  include Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    model: String,
    machine_name: String?,
  )
end

class Core::Instance::Component < Core::InstanceJSON::Component
  include Core::Instance
  extend Core::Instance::FromJSON
  getter model_ref : Core::Model::Component

  def plug(machine : Core::Instance::Machine, mods : Mods)
    hook = (activity.hooks["install"]?)
    hook.exec(mods, self, machine.id) unless hook.nil?
  end
end
