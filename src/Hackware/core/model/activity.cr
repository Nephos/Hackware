# An activity is executed by a `Hacker`.
# The hooks are linked to the mod logic (install, start)
class Core::Model::Activity
  include Core::Model
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

  Core::Terminal.__set_operators(
    "name", "duration", "attributes_usage"
  )

  Core::Terminal.__define_read_operators(
    "name", "duration", "attributes_usage"
  )
end
