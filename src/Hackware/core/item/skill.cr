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
  getter owner : Game::Person

  #############################################################################

  Core::Resolvable.__set_paths(
    "owner",
  )

  Core::Resolvable.__define_read_paths(
    "owner"
  )

  Core::Terminal.__set_operators(
    "level_greater",
    "level_greater_or_eq",
    "level_less",
    "level_less_or_eq",
    "level_eq",
    "xp_is_max"
  )

  Core::Terminal.__define_operator "level_greater", UInt32 do |args|
    @level > args[0]
  end

  Core::Terminal.__define_operator "level_greater_or_eq", UInt32 do |args|
    @level >= args[0]
  end

  Core::Terminal.__define_operator "level_less", UInt32 do |args|
    @level < args[0]
  end

  Core::Terminal.__define_operator "level_less_or_eq", UInt32 do |args|
    @level <= args[0]
  end

  Core::Terminal.__define_operator "level_eq", UInt32 do |args|
    @level == args[0]
  end

  Core::Terminal.__define_operator "xp_is_max" do
    @xp >= 1.0
  end
end
