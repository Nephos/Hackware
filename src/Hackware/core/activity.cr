# An activity is executed by a `Hacker`.
# The hooks are linked to the mod logic (install, start)
class Core::Activity
  JSON.mapping(
    # Name of the activity to display. Also unique.
    name: String,
    # Base duration of the activity. TODO improve this definition
    duration: Int32,
    # Requirements to execute this task.
    requirements: Array(Requirement),
    # Usage of the machine during the execution of the activity.
    attributes_usage: Hash(String, Float64),
    # Scripts.
    hooks: Hash(String, Hook),
  )

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
    hook = (self.hooks[hook]?)
    hook.exec(mods, self) unless hook.nil?
  end
end
