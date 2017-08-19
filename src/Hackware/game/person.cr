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

  def uid_eq(args)
    raise "Invalid requirement (uid_eq) with arguments (#{args})" if args.size != 1
    arg = UInt32.new(args.first)
    return @uid == arg
  end
end
