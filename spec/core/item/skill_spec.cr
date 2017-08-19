require "spec"

describe Core::Item::Skill do
  it "test simle item" do
    skill_model = Core::Model::Skill.from_json(%({ "name": "Programming" }))
    owner = Game::Person.new(0)

    skill = Core::Item::Skill.from_json(
      %({ "id": 0, "model": "Programming", "xp": 0.0, "level": 1 }), [skill_model], owner)
    skill.id.should eq 0
    skill.model.should eq "Programming"
    skill.model_ref.should eq skill_model
    skill.xp.should eq 0.0
    skill.level.should eq 1

    skill.level_greater(["0"]).should be_true
    skill.level_greater(["1"]).should be_false
    skill.level_greater_or_eq(["0"]).should be_true
    skill.level_greater_or_eq(["1"]).should be_true
    skill.level_greater_or_eq(["0"]).should be_true
    skill.level_less(["2"]).should be_true
    skill.level_less(["1"]).should be_false
    skill.level_less_or_eq(["1"]).should be_true
    skill.level_less_or_eq(["0"]).should be_false
    skill.level_eq(["1"]).should be_true
    skill.level_eq(["0"]).should be_false
    skill.xp_is_max([] of String).should be_false
    expect_raises { skill.level_greater(["0", "too_many_args"]) }
    expect_raises { skill.xp_is_max(["too_many_args"]) }
  end
end
