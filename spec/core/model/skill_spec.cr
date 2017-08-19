describe Core::Model::Skill do
  it "test no requirement" do
    skill = Core::Model::Skill.from_json(%({"name": "Hacking"}))
    skill.name.should eq "Hacking"
  end
end
