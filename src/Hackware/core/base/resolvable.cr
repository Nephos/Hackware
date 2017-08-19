module Core::Resolvable
  # Resolve a complete path
  def resolve_path(path = Array(String)) : Core::Resolvable
    return self if path.empty?
    current_partial = path.shift # remove the first element
    following_resolvable = _resolve_partial_path(current_partial)
    following_resolvable.resolve_path(path)
  end

  # Resolve a part of a path, by using `resolve(function)`
  private def _resolve_partial_path(partial : String) : Core::Resolvable
    return self if partial == "self"
    self.resolve(partial)
  end

  # Resolve a part of a path.
  #
  # fct is a string to indicate which functon the resolvable has to execute to resolve the problem.
  abstract def resolve(fct : String) : Core::Resolvable
end
