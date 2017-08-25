require "spec"

describe Core::Item::Skill do
  it "test simle item" do
    skill_model = Core::Model::Skill.from_json(%({ "name": "Programming" }))
    owner = Owner::Person.new(0)

    skill = Core::Item::Skill.from_json(
      %({ "id": 0, "model": "Programming", "xp": 0.0, "level": 1 }), [skill_model], owner)
    skill.id.should eq 0
    skill.model.should eq "Programming"
    skill.model_ref.should eq skill_model
    skill.xp.should eq 0.0
    skill.level.should eq 1

    skill.termine("level_greater", ["0"]).should be_true
    skill.termine("level_greater", ["1"]).should be_false
    skill.termine("level_greater_or_eq", ["0"]).should be_true
    skill.termine("level_greater_or_eq", ["1"]).should be_true
    skill.termine("level_greater_or_eq", ["0"]).should be_true
    skill.termine("level_less", ["2"]).should be_true
    skill.termine("level_less", ["1"]).should be_false
    skill.termine("level_less_or_eq", ["1"]).should be_true
    skill.termine("level_less_or_eq", ["0"]).should be_false
    skill.termine("level_eq", ["1"]).should be_true
    skill.termine("level_eq", ["0"]).should be_false
    skill.termine("xp_is_max", [] of String).should be_false
    expect_raises { skill.termine("level_greater", ["0", "too_many_args"]) }
    expect_raises { skill.termine("xp_is_max", ["too_many_args"]) }

    skill.termine("xp", [] of String).should eq 0
    skill.termine("level", [] of String).should eq 1
  end
end
