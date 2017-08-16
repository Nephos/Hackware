require "tempfile"

describe Mods do
  it "basic test" do
    Tempfile.open("mod_test") do |f|
      f.puts "function mod_test(a) { return a + 1; }"
      f.flush
      mods = Mods.new
      mods.load f.path
      mods.list.should eq [f.path]
      mods.sandbox.exec("print(mod_test(1))")
      mods.sandbox.call("mod_test", 2).should eq 3
    end
  end
end
