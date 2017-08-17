class Game::Person
  JSON.mapping(
    # Skill value = Float64.
    skills: Array(Core::Skill::Instance),
    # Machines owned.
    machines: Array(Core::Machine::Instance),
    # Inventory of components.
    inventory_components: Array(Core::Component::Instance),
  )
end
