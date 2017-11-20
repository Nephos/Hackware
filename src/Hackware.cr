require "./Hackware/__init"

mods = Mods::Loader.new
Game::World.new mods.models, mods.sandbox
Network::Server.init.start
