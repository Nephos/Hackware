require "spec"

describe Core::Model::Component do
  it "test no requirement" do
    component = Core::Model::Component.from_json(%({"name": "graphic card", "attributes": {"comp_speed": 3}, "slots": ["graphic"], "requirements": [], "hooks": {}}))
    component.name.should eq "graphic card"
    component.attributes["comp_speed"].should eq 3.0
    component.slots.first.should eq "graphic"
    component.requirements.should eq [] of Core::Requirement
    component.hooks.empty?.should eq true
  end
end
