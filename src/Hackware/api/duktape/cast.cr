module DuktapeBuild::Cast
  extend self

  def cast_to_any(x :  Array)
    return x.map { |e| cast_to_any(e).as(Any) }.as(Any)
  end

  def cast_to_any(x : Hash)
    h = Hash(String, Any).new
    x.each do |(k, v)|
      h[k] = cast_to_any(v).as(Any)
    end
    h.as(Any)
  end

  def cast_to_any(x)
    x.as(Any)
  end

  def get_current_value(env, idx)
    {% for type_check, type_get in BUILD %}
      should_get_value = env.{{ type_check }}(idx)
      if should_get_value
        return ({{ type_get }}).call(env, idx)
      end
    {% end %}
    raise "Value not found"
  end
end
