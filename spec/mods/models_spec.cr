require "spec"
require "tempfile"

describe Mods::Models do
  it "basic test" do
    mods = Mods::Models.new
    Tempfile.open("mod_test") do |f|
      f.puts %({"skills": [ {"name": "HackSkill"} ]})
      f.flush
      mods.load f.path
      mods.list.should eq [f.path]
    end
    obj = mods.models.first
    obj.should be_a Core::Model::Skill
    obj.name.should eq "HackSkill"
  end
end
