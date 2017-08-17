describe Core::Model::Component do
  it "basic test" do
    component = Core::Model::Component.from_json(%({"name": "graphic card", "attributes": {"comp_speed": 3}, "slots": ["graphic"], "requirements": []}))
    component.name.should eq "graphic card"
    component.attributes["comp_speed"].should eq 3.0
    component.slots.first.should eq "graphic"
    component.requirements.should eq [] of Core::Requirement
  end
end
