require "duktape"
require "duktape/runtime"

# This class loads script mods.
# It loads the scripts into a sandbox.
class Mods::Sandbox
  getter list : Array(String)
  getter js : Duktape::Runtime
  getter js_context : Duktape::Sandbox

  def initialize
    @list = Array(String).new
    @js_context = Duktape::Sandbox.new
    @js = Duktape::Runtime.new @js_context
  end

  # Load a new mod.
  # Add the path of the mod to the list of the loaded mods,
  # then load the js into the sandbox.
  def load(path : String)
    path = File.expand_path(path)
    raise "No such file `#{path}`" unless File.exists? path
    @list << path
    _load_js_at_path(path)
  end

  # :nodoc:
  private def _load_js_at_path(path : String)
    mod_code = File.read(path)
    mod_name = File.basename(path).split(".").first
    raise "Invalid Mod file name `#{mod_name}`" unless mod_name =~ /^[a-zA-Z][a-zA-Z0-9_-]*$/
    mod_code = "var #{mod_name} = #{mod_code}"
    begin
      @js.eval mod_code
    rescue err
      STDERR.puts "Invalid mod_code `#{mod_name}`"
      raise err
    end
  end
end
