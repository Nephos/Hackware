class Core::Person
  JSON.mapping(
    # Skill value = Float64.
    skills: Hash(Skill, Float64),
    # Machines owned.
    machines: Array(Machine),
    # Inventory of components.
    inventory_components: Array(Component),
  )
end
