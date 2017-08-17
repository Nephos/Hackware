require "./person"

class Core::Hacker < Core::Person
  def initialize(pull : ::JSON::PullParser)
    super(pull)
  end

  def level
    skill.floor
  end

  def xp
    skill - level
  end
end
