class Hook
  JSON.mapping(
    function: String,
    mod: String,
  )

  def exec(context, mods, *args)             # TODO improve context (player, machine target, ...)
    mods.sandbox.eval "#{mod}.#{function}()" # TODO add args
  end
end
