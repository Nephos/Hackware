class Game::Person
  include Core::Traversable

  JSON.mapping(
    # unique id
    uid: UInt32,
    # Skill value = Float64.
    skills: Array(Core::Item::Skill::Id),
    # Machines owned.
    machines: Array(Core::Item::Machine::Id),
    # Inventory of components.
    inventory_components: Array(Core::Item::Component::Id),
  )

  def initialize(@uid,
                 @skills = Array(Core::Item::Skill::Id).new,
                 @machines = Array(Core::Item::Machine::Id).new,
                 @inventory_components = Array(Core::Item::Component::Id).new)
  end

  def initialize(uid : Int32,
                 @skills = Array(Core::Item::Skill::Id).new,
                 @machines = Array(Core::Item::Machine::Id).new,
                 @inventory_components = Array(Core::Item::Component::Id).new)
    raise "Invalid uid (#{uid}) if uid < 0" if uid < 0
    @uid = uid.to_u32
  end

  #############################################################################

  Core::Terminal.__set_operators(
    "uid_eq",
  )

  def resolve(path : String) : Core::Resolvable
    self
  end

  Core::Terminal.__define_operator "uid_eq", UInt32 do |args|
    return @uid == args[0]
  end
end
