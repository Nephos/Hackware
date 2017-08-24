require "duktape"
require "duktape/runtime"

# require "json"

class Mods::Sandbox
  getter list : Array(String)
  getter sandbox : Duktape::Runtime

  def initialize
    @list = Array(String).new
    @sandbox = Duktape::Runtime.new
  end

  # Load a new mod.
  # Add the path of the mod to the list of the loaded mods,
  # then load the js into the sandbox.
  def load(path : String)
    path = File.expand_path(path)
    raise "No such file (#{path})" unless File.exists? path
    @list << path
    _load_js_at_path(path)
  end

  # :nodoc:
  private def _load_js_at_path(path : String)
    mod_code = File.read(path)
    mod_name = File.basename(path).split(".").first
    raise "Invalid Mod file name (#{mod_name})" unless mod_name =~ /^[a-zA-Z][a-zA-Z0-9_-]*$/
    mod_code = "var #{mod_name} = #{mod_code}"
    begin
      @sandbox.eval mod_code
    rescue err
      STDERR.puts "Invalid mod_code (#{mod_name})"
      raise err
    end
  end
end
