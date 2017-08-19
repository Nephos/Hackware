describe Core::Requirement do
  it "resolve path" do
    model = Core::Model::Skill.from_json %({"name": "Hack"})
    insta = Core::Item::Skill.from_json %({"id": 0, "model": "Hack", "level": 1, "xp": 0.5}), [model], Game::Person.new(0)
    req = Core::Requirement.from_json %({"path": "self", "operator": "level_greater_or_eq", "values": ["3"]})
    req.resolve_path(insta).should eq insta
  end

  it "resolve value" do
    model = Core::Model::Skill.from_json %({"name": "Hack"})
    insta = Core::Item::Skill.from_json %({"id": 0, "model": "Hack", "level": 1, "xp": 0.5}), [model], Game::Person.new(0)
    req1 = Core::Requirement.from_json %({"path": "self", "operator": "level_greater_or_eq", "values": ["3"]})
    req2 = Core::Requirement.from_json %({"path": "self", "operator": "level_greater_or_eq", "values": ["1"]})
    req3 = Core::Requirement.from_json %({"path": "self.owner", "operator": "uid_eq", "values": ["0"]})
    req4 = Core::Requirement.from_json %({"path": "self.owner", "operator": "uid_eq", "values": ["2"]})
    req1.resolve_value(insta).should eq false
    req2.resolve_value(insta).should eq true
    req3.resolve_value(insta).should eq true
    req4.resolve_value(insta).should eq false
  end
end
