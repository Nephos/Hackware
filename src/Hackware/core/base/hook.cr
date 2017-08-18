class Core::Hook
  JSON.mapping(
    function: String,
    mod: String,
  )

  alias Atom = Int64 | Float64 | String | Nil
  alias Comp = Array(Comp) | Hash(Comp, Comp) | Atom

  def exec(mods, context : Core::Instance, *args : Comp)
    js_args = args.map{|e| e.inspect }.join(", ")
    mods.sandbox.eval "#{mod}.#{function}(#{context.id}, #{js_args})"
  end
end
