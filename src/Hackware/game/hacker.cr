require "./person"

class Game::Hacker < Game::Person
  def initialize(pull : ::JSON::PullParser)
    super(pull)
  end
end
