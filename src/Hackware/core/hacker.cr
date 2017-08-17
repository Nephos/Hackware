require "./person"
require "./skill"

class Core::Hacker < Core::Person
  # Skill value = Float64
  JSON.mapping(
    skills: Hash(Skill, Float64),
  )

  def level
    skill.floor
  end

  def xp
    skill - level
  end
end
