class Game::Person
  JSON.mapping(
    # Skill value = Float64.
    skills: Array(Core::Instance::Skill),
    # Machines owned.
    machines: Array(Core::Instance::Machine),
    # Inventory of components.
    inventory_components: Array(Core::Instance::Component),
  )
end
