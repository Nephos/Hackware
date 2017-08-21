require "./resolvable"
require "./terminal"

# Object which can be resolved (with path) and which have terminal operator (which return serialisable object).
module Core::Traversable
  include Core::Resolvable
  include Core::Terminal
end
