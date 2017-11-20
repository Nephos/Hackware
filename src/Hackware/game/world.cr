class Game::World < API::World
  getter persons : Hash(UInt32, Owner::Person)
  getter machines : Hash(UInt32, Core::Item::Machine)
  getter components : Hash(UInt32, Core::Item::Component)
  getter files : Hash(UInt32, Core::Item::File)
  getter skills : Hash(UInt32, Core::Item::Skill)
  getter activities : Hash(UInt32, Core::Item::Activity)
  getter models : Mods::Models
  getter sandbox : Mods::Sandbox

  def initialize(@models, @sandbox)
    @persons = Hash(UInt32, Owner::Person).new
    @machines = Hash(UInt32, Core::Item::Machine).new
    @components = Hash(UInt32, Core::Item::Component).new
    @files = Hash(UInt32, Core::Item::File).new
    @skills = Hash(UInt32, Core::Item::Skill).new
    @activities = Hash(UInt32, Core::Item::Activity).new
    super()
  end
end
