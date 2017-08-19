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
  include Core::Resolvable
  include Core::Terminal

  #############################################################################

  # Core::Resolve.__set_operators(
  #   "player",
  # )

  Core::Terminal.__set_operators(
    "level_greater",
    "level_greater_or_eq",
    "level_less",
    "level_less_or_eq",
    "level_eq",
  )

  def resolve(fct : String) : Core::Resolvable
    self
  end

  def termine(operator : String, values : Array(String)) : Bool
    operator_fct = Core::Terminal.__get_operator(operator)
    raise %(No operator "#{operator}" in (#{self.class})) if operator_fct.nil?
    operator_fct.call(self, values)
  end

  def level_greater(args)
    raise "Invalid requirement (level_greater) with arguments (#{args})" if args.size != 1
    arg = UInt32.new(args.first)
    return @level > arg
  end

  def level_greater_or_eq(args)
    raise "Invalid requirement (level_greater_or_eq) with arguments (#{args})" if args.size != 1
    arg = UInt32.new(args.first)
    return @level >= arg
  end

  def level_less(args)
    raise "Invalid requirement (level_less) with arguments (#{args})" if args.size != 1
    arg = UInt32.new(args.first)
    return @level < arg
  end

  def level_less_or_eq(args)
    raise "Invalid requirement (level_less_or_eq) with arguments (#{args})" if args.size != 1
    arg = UInt32.new(args.first)
    return @level <= arg
  end

  def level_eq(args)
    raise "Invalid requirement (level_eq) with arguments (#{args})" if args.size != 1
    arg = UInt32.new(args.first)
    return @level == arg
  end
end
