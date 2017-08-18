describe Core::Instance::Component do
  it "test no machine" do
    componentModel = Core::Model::Component.from_json(%({"name": "graphic card", "attributes": {"comp_speed": 3}, "slots": ["graphic"], "requirements": []}))
    componentNoMachineJson = Core::InstanceJSON::Component.from_json(%({"id": 0, "model": "graphic card"}))
    componentNoMachineJson.id.should eq 0
    componentNoMachineJson.model.should eq "graphic card"
    componentNoMachineJson.machine_name.should eq nil

    componentNoMachine = Core::Instance::Component.from_json(%({"id": 0, "model": "graphic card"}), [componentModel])
    componentNoMachine.id.should eq 0
    componentNoMachine.model.should eq "graphic card"
    componentNoMachine.model_ref.name.should eq "graphic card"
    componentNoMachine.model_ref.attributes["comp_speed"].should eq 3.0
    componentNoMachine.model_ref.requirements.should eq [] of Core::Requirement
  end

  it "test with machine" do
    componentModel = Core::Model::Component.from_json(%({"name": "graphic card", "attributes": {"comp_speed": 3}, "slots": ["graphic"], "requirements": []}))
    componentNoMachineJson = Core::InstanceJSON::Component.from_json(%({"id": 0, "model": "graphic card", "machine_name": "computer"}))
    componentNoMachineJson.id.should eq 0
    componentNoMachineJson.model.should eq "graphic card"
    componentNoMachineJson.machine_name.should eq "computer"
  end
end
