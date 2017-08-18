class Test::Core::Instance::Skill < Core::Instance::Skill
  def initialize(@id, @model, @level, @xp, @model_ref)
  end
end

describe Core::Hook do
  it "basic exec" do
    hook = Core::Hook.from_json(%({ "function": "fct_test", "mod": "mod_test" }))
    mods = Mods.new
    Tempfile.open("mod_test") do |f|
      f.puts %({fct_test: function(a, b) { return "result: " + a + " = " + b; }})
      f.flush
      mods.load f.path
    end
    core_model = Core::Model::Skill.from_json %({ "name": "tmodel" })
    core_instance = Test::Core::Instance::Skill.new id: 0_u32, model: "tmodel", level: 0_u32, xp: 0.0, model_ref: core_model
    hook.exec(mods, core_instance, "ok").should eq "result: 0 = ok"
  end
end
