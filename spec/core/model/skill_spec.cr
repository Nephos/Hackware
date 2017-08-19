require "spec"

describe Core::Model::Skill do
  it "test no requirement" do
    skill = Core::Model::Skill.from_json(%({"name": "Hacking"}))
    skill.name.should eq "Hacking"
  end

  it "test api" do
    skill = Core::Model::Skill.from_json(%({"name": "Hacking"}))
    skill.termine("name", [] of String).should eq "Hacking"
  end
end
