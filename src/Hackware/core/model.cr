require "./base/resolvable"

module Core::Model
  include Core::Resolvable

  abstract def name
end
