require "spec"
require "tempfile"

describe Mods::Loader do
  it "basic test" do
    `rm -rf __mods/`
    `mkdir -p __mods/scripts/ __mods/objects/`
    scripts = %w(test1 test2).map { |script| File.expand_path "__mods/scripts/#{script}.js" }
    scripts.each { |script| `echo '{}' > "#{script}"` }
    objects = %w(test1 test2).map { |object| File.expand_path "__mods/objects/#{object}.json" }
    objects.each { |object| `echo '{}' > "#{object}"` }

    loader = Mods::Loader.new("__mods")
    loader.script_mods.should eq scripts
    loader.script_mod_exists?("test1").should be_true
    loader.script_mod_exists?("test3").should be_false

    `rm -rf __mods/`
  end
end
