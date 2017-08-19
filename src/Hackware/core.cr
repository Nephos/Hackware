require "./core/base"
require "./core/item_json"
require "./core/item"
require "./core/model"

# The base objects are not extensibles with mods.
# They are requirements, hooks, ...
require "./core/base/*"

# Core classes are extensibles with mods.
# The items of thoses classes are created from the JSON files.
# Those items are the models used by hackers etc. to instanciate their own objects.
require "./core/model/*"

# Item objects are linked to their base properties (Core object) via a "model" id (the name of the core object). Those objects are owned by each `Person`
require "./core/item/*"
