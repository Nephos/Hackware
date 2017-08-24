require "spec"
require "tempfile"

describe Mods::Sandbox do
  it "basic test" do
    mods = Mods::Sandbox.new
    Tempfile.open("mod_test") do |f|
      f.puts "{mod_entry: function(a) { return a + 1; }}"
      f.flush
      mods.load f.path
      mods.list.should eq [f.path]
    end
    mods.sandbox.call("mod_test.mod_entry", 2).should eq 3
  end
end
