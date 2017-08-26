class Core::ItemJSON::Skill
  alias Id = UInt32
  include Core::ItemJSON
  JSON.mapping(
    id: Id,
    model: String,
    level: UInt32,
    xp: Float64,
  )
end

class Core::Item::Skill < Core::ItemJSON::Skill
  include Core::Item
  extend Core::Item::FromJSON
  getter model_ref : Core::Model::Skill
  getter owner : Owner::Person

  #############################################################################

  RuntimeCall.extends do
    getter_runtime_call(
      "id",
      "model",
      "level",
      "xp",
      "owner"
    )

    define_runtime_call "level_greater", UInt32 do |args|
      @level > args[0]
    end

    define_runtime_call "level_greater_or_eq", UInt32 do |args|
      @level >= args[0]
    end

    define_runtime_call "level_less", UInt32 do |args|
      @level < args[0]
    end

    define_runtime_call "level_less_or_eq", UInt32 do |args|
      @level <= args[0]
    end

    define_runtime_call "level_eq", UInt32 do |args|
      @level == args[0]
    end

    define_runtime_call "xp_is_max" do
      @xp >= 1.0
    end
  end
end
