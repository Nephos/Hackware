module Core::Model
  include Core::Traversable

  abstract def name

  def resolve(path : String) : Core::Resolvable
    raise Core::Resolvable::UnresolvablePath.new "There are no path in Models"
    self
  end
end
