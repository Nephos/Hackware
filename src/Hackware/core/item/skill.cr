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

  Core::Terminal.__set_operators(
    "level_greater",
    "level_greater_or_eq",
    "level_less",
    "level_less_or_eq",
    "level_eq",
    "xp_is_max"
  )

  # arguments:
  #  - level: UInt32
  def level_greater(values)
    # raise "Invalid requirement (level_greater) with arguments (#{values})" if values.size != 1
    # arg = UInt32.new(values.first)
    args = __require_arguments("level_greater", values, UInt32)
    return @level > args[0]
  end

  # arguments:
  #  - level: UInt32
  def level_greater_or_eq(values)
    args = __require_arguments("level_greater_or_eq", values, UInt32)
    return @level >= args[0]
  end

  # arguments:
  #  - level: UInt32
  def level_less(values)
    args = __require_arguments("level_less", values, UInt32)
    return @level < args[0]
  end

  # arguments:
  #  - level: UInt32
  def level_less_or_eq(values)
    args = __require_arguments("level_less_or_eq", values, UInt32)
    return @level <= args[0]
  end

  # arguments:
  #  - level: UInt32
  def level_eq(values)
    args = __require_arguments("level_eq", values, UInt32)
    return @level == args[0]
  end

  # arguments:
  #  - level: UInt32
  def xp_is_max(values)
    __require_no_arguments("is_max", values)
    nop = 1
    return @xp >= 1.0
  end
end
