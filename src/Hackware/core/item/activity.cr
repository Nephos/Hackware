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
  getter owner : Owner::Person

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

  #############################################################################

  Core::Resolvable.__set_paths(
    "owner",
  )

  Core::Resolvable.__define_read_paths(
    "owner"
  )

  Core::Terminal.__set_operators(
    "is_completed",
  )

  Core::Terminal.__define_operator "is_attached_to" do
    @completion >= 1.0
  end
end
