require "spec"

describe Core::Model::Activity do
  it "test no requirement" do
    activity = Core::Model::Activity.from_json(%(
    {
      "name": "DDOS with ping",
      "duration": 600,
      "attributes_usage": {"computations": 25.0},
      "hooks": {"install": {"mod": "DDOS", "function": "activity DDOS with ping"}},
      "requirements": []
    }))
    activity.name.should eq "DDOS with ping"
    activity.duration.should eq 600
    activity.attributes_usage.should eq({"computations" => 25.0})
    activity.requirements.should eq [] of Core::Requirement
    activity.hooks["install"]?.should_not be_nil
    activity.hooks["install"].mod.should eq "DDOS"
    activity.hooks["install"].function.should eq "activity DDOS with ping"
  end
end
