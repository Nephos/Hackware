class Game::World
  getter person_list : Hash(UInt32, Owner::Person)
  getter machine_list : Hash(UInt32, Core::Item::Machine)
  getter component_list : Hash(UInt32, Core::Item::Component)
  getter file_list : Hash(UInt32, Core::Item::File)
  getter skill_list : Hash(UInt32, Core::Item::Skill)
  getter activity_list : Hash(UInt32, Core::Item::Activity)

  def initialize()
    @person_list = new Hash(UInt32, Owner::Person)
    @machine_list = new Hash(UInt32, Core::Item::Machine)
    @component_list = new Hash(UInt32, Core::Item::Component)
    @file_list = new Hash(UInt32, Core::Item::File)
    @skill_list = new Hash(UInt32, Core::Item::Skill)
    @activity_list = new Hash(UInt32, Core::Item::Activity)
  end
end
