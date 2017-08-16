require "./hook"

# An activity is executed by a `Hacker`.
# The hooks are linked to the mod logic (install, start)
class Core::Activity
  YAML.mapping(
    name: String,
    duration: Int32,
    requirements: Array(Requirement),
    attributes_usage: Hash(String, Float64),
    hooks: Hash(String, Hook),
  )

  def start
    exec "before_start"
    exec "start"
    exec "after_start"
  end

  def install
    exec "before_install"
    exec "install"
    exec "after_install"
  end

  # :nodoc:
  private def exec(hook : String)
    hook = (self.hooks[hook]?)
    hook.exec self unless hook.nil?
  end
end
