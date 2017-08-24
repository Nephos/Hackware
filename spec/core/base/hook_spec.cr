require "spec"

describe Core::Hook do
  it "basic exec" do
    hook = Core::Hook.from_json(%({ "function": "fct_test", "mod": "mod_test" }))
    mods = Mods::Sandbox.new
    Tempfile.open("mod_test") do |f|
      f.puts %({fct_test: function(a, b) { return "result: " + a + " = " + b; }})
      f.flush
      mods.load f.path
    end
    core_model = Core::Model::Skill.from_json %({ "name": "tmodel" })
    core_item = Core::Item::Skill.from_json %({ "id": 0, "model": "tmodel", "level": 0, "xp": 0.0 }), [core_model], Game::Person.new(0)
    hook.exec(mods, core_item, "ok").should eq "result: 0 = ok"
  end
end
