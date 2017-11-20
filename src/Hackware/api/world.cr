abstract class API::World
  abstract def persons : Hash(UInt32, Owner::Person)
  abstract def machines : Hash(UInt32, Core::Item::Machine)
  abstract def components : Hash(UInt32, Core::Item::Component)
  abstract def files : Hash(UInt32, Core::Item::File)
  abstract def skills : Hash(UInt32, Core::Item::Skill)
  abstract def activities : Hash(UInt32, Core::Item::Activity)
  abstract def models : Mods::Models
  abstract def sandbox : Mods::Sandbox

  def initialize
  end
end
