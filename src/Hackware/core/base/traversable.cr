require "./resolvable"
require "./terminal"

module Core::Traversable
  include Core::Resolvable
  include Core::Terminal
end
