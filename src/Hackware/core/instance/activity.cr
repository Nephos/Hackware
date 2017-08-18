class Core::InstanceJSON::Activity
  include Core::InstanceJSON
  JSON.mapping(
    id: UInt32,
    model: String,
    completion: Float64,
  )
end

class Core::Instance::Activity < Core::InstanceJSON::Activity
  include Core::Instance
  extend Core::Instance::FromJSON
  getter model_ref : Core::Model::Activity

  # Execute a hook.
  #
  # - hook: The name of the hook to execute.
  # - mods: The sandbox where the mods are loaded.
  #
  # Example
  # ```
  # activity.exec "before_install", mods
  # activity.exec "install", mods
  # activity.exec "after_install", mods
  # ```
  def exec(hook : String, mods : Mods) # TODO improve context (player, machine, target, ...)
    hook = (activity.hooks[hook]?)
    hook.exec(self, mods) unless hook.nil?
  end
end
