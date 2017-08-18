describe Core::Model::Activity do
  it "test no requirement" do
    component = Core::Model::Activity.from_json(%(
    {
      "name": "DDOS with ping",
      "duration": 600,
      "attributes_usage": {"computations": 25.0},
      "hooks": {"install": {"mod": "DDOS", "function": "activity DDOS with ping"}},
      "requirements": []
    }))
    component.name.should eq "DDOS with ping"
    component.duration.should eq 600
    component.attributes_usage.should eq({"computations" => 25.0})
    component.requirements.should eq [] of Core::Requirement
    component.hooks["install"]?.should be_a Core::Hook
    component.hooks["install"].mod.should eq "DDOS"
    component.hooks["install"].function.should eq "activity DDOS with ping"
  end
end
