module Core::Resolvable
  # Resolve a part of a path.
  #
  # fct is a string to indicate which functon the resolvable has to execute to resolve the problem.
  abstract def resolve(fct : String) : Core::Resolvable

  # Defines a list of functions that are used to resolve paths, and defines `resolve`.
  #
  # It makes the `resolve` able to call the function by associating their name with a proc.
  macro __set_paths(*paths)
    RESOLVABLE_PATHS = {
      {% for op in paths %}
        {{op}} => -> (resolvable : self) { resolvable.{{op.id}}() },
      {% end %}
    }

    # Read into the list of paths functions to call the right one.
    def resolve(path : String) : Core::Resolvable
      path_fct = RESOLVABLE_PATHS[path]?
      raise UnresolvablePath.new %(No resolvable path "#{path}" in (#{self.class})) if path_fct.nil?
      path_fct.call(self)
    end
  end

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

  class UnresolvablePath < Exception
  end
end
