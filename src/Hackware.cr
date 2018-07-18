require "./Hackware/__init"

MODS = Mods::Loader.new
WORLD = Game::World.new MODS.models, MODS.sandbox

ApiBuild::Player.list_players(::WORLD)

# ::WORLD.persons[42u32] = Owner::Person.new(42u32)
# puts WORLD.sandbox.js.eval("list_players()")

Network::Server.init.start
