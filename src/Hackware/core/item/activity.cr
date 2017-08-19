class Core::ItemJSON::Activity
  alias Id = UInt32
  include Core::ItemJSON
  JSON.mapping(
    id: Id,
    model: String,
    completion: Float64,
  )
end

class Core::Item::Activity < Core::ItemJSON::Activity
  include Core::Item
  extend Core::Item::FromJSON
  getter model_ref : Core::Model::Activity
  getter owner : Game::Person

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
    hook.exec(mods, self) unless hook.nil?
  end
end
