class Game::Person
  JSON.mapping(
    # unique id
    uid: UInt32,
    # Skill value = Float64.
    skills: Array(Core::Instance::Skill::Id),
    # Machines owned.
    machines: Array(Core::Instance::Machine::Id),
    # Inventory of components.
    inventory_components: Array(Core::Instance::Component::Id),
  )

  def initialize(@uid,
                 @skills = Array(Core::Instance::Skill::Id).new,
                 @machines = Array(Core::Instance::Machine::Id).new,
                 @inventory_components = Array(Core::Instance::Component::Id).new)
  end

  def initialize(uid : Int32,
                 @skills = Array(Core::Instance::Skill::Id).new,
                 @machines = Array(Core::Instance::Machine::Id).new,
                 @inventory_components = Array(Core::Instance::Component::Id).new)
    raise "Invalid uid (#{uid}) if uid < 0" if uid < 0
    @uid = uid.to_u32
  end
end
