describe Core::Requirement do
  it "resolve type" do
    model = Core::Model::Skill.from_json %({"name": "Hack"})
    insta = Core::Instance::Skill.from_json %({"id": 0, "model": "Hack", "level": 0, "xp": 0.5}), [model], Game::Person.new(0)
    req = Core::Requirement.from_json %({"path": "self.level", "operator": ">=", "value": ["3"]})
    # req.resolve_path(insta).should eq 0
  end
end
