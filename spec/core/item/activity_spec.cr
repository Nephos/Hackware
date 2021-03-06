require "spec"

describe Core::Item::Activity do
  it "test simple item" do
    activity_model = Core::Model::Activity.from_json(%(
    {
      "name": "DDOS with ping",
      "duration": 600,
      "attributes_usage": {"computations": 25.0},
      "hooks": {"install": {"mod": "DDOS", "function": "activity DDOS with ping"}},
      "requirements": []
    }))
    owner = Owner::Person.new(0)

    activity = Core::Item::Activity.from_json(%({ "id": 0, "model": "DDOS with ping", "completion": 0.0 }), [activity_model], owner)
    activity.id.should eq 0
    activity.model.should eq "DDOS with ping"
    activity.completion.should eq 0.0
    activity.model_ref.should be activity_model
    activity.owner.should be owner
  end
end
