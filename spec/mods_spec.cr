require "tempfile"

describe Mods do
  it "basic test" do
    Tempfile.open("mod_test") do |f|
      f.puts "{mod_entry: function(a) { return a + 1; }}"
      f.flush
      mods = Mods.new
      mods.load f.path
      mods.list.should eq [f.path]
      mods.sandbox.call("mod_test.mod_entry", 2).should eq 3
    end
  end
end
