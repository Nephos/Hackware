require "./hook"

# An activity is executed by a `Hacker`.
# The hooks are linked to the mod logic (install, start)
class Core::Activity
  JSON.mapping(
    name: String,
    duration: Int32,
    requirements: Array(Requirement),
    attributes_usage: Hash(String, Float64),
    hooks: Hash(String, Hook),
  )

  def start(mods)
    exec "before_start", mods
    exec "start", mods
    exec "after_start", mods
  end

  def install(mods)
    exec "before_install", mods
    exec "install", mods
    exec "after_install", mods
  end

  # :nodoc:
  private def exec(hook : String, mods : Mods)
    hook = (self.hooks[hook]?)
    hook.exec(mods, self) unless hook.nil?
  end
end
