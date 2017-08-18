class Core::Hook
  JSON.mapping(
    function: String,
    mod: String,
  )

  def exec(context : Core::Instance, mods, *args)         # TODO improve context (player, machine target, ...)
    mods.sandbox.eval "#{mod}.#{function}(#{context.id})" # TODO add args
  end
end
