require "duktape"
require "duktape/runtime"

class Mods
  getter list : Array(String)
  getter sandbox : Duktape::Runtime

  def initialize
    @list = Array(String).new
    @sandbox = Duktape::Runtime.new
  end

  def load(path : String)
    path = File.expand_path(path)
    raise "No such file (#{path})" unless File.exists? path
    @list << path
    _load_js_at_path(path)
  end

  # :nodoc:
  private def _load_js_at_path(path : String)
    mod_code = File.read(path)
    @sandbox.eval mod_code
  end
end
