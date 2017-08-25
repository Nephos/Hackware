require "./person"

class Owner::Hacker < Owner::Person
  def initialize(pull : ::JSON::PullParser)
    super(pull)
  end
end
