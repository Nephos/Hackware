module Core::Model
  abstract def name
  include Core::Traversable

  def resolve(path : String) : Core::Resolvable
    raise Core::Resolvable::UnresolvablePath.new "There are no path in Models"
    self
  end
end
