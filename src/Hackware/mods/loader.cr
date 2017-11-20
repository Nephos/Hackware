require "./sandbox"
require "./models"

class Mods::Loader
  property base_directory : String
  getter sandbox : Mods::Sandbox
  getter models : Mods::Models

  def initialize(@base_directory = "./mods",
                 @sandbox = Mods::Sandbox.new,
                 @models = Mods::Models.new)
  end

  # Returns the directory where the object mods are stored.
  def object_mods_directory
    File.expand_path "objects", @base_directory
  end

  # Returns the directory where the script mods are stored.
  def script_mods_directory
    File.expand_path "scripts", @base_directory
  end

  # Returns the path to the file that list the object mods enabled.
  def object_mods_list
    File.expand_path "objects/list.txt", @base_directory
  end

  # Returns the path to the file that list the script mods enabled.
  def script_mods_list
    File.expand_path "scripts/list.txt", @base_directory
  end

  # Returns the list of the object mods avaliable.
  def object_mods
    globbing = File.expand_path "*", object_mods_directory
    Dir.glob globbing
  end

  # Returns the list of the script mods avaliable.
  def script_mods
    globbing = File.expand_path "*", script_mods_directory
    Dir.glob globbing
  end

  # Verifies if the object mod is avaliable.
  def object_mod_exists?(mod)
    object_mods.includes? File.expand_path("#{mod}.json", object_mods_directory)
  end

  # Verifies if the script mod is avaliable.
  def script_mod_exists?(mod)
    script_mods.includes? File.expand_path("#{mod}.js", script_mods_directory)
  end

  # Load all the object mods enabled.
  def load_objects
    raise "object list does not exits at `#{object_mods_list}`" unless File.exists?(object_mods_list)
    list = File.read(object_mods_list).split("\n")
    list.each { |mod| "Mod `#{mod}` does not exists" unless object_mod_exists?(object_mods) }
    list.each { |mod| _load_object object_mods }
  end

  # Load all the script mods enabled.
  def load_scripts
    raise "script list does not exits at `#{script_mods_list}`" unless File.exists?(script_mods_list)
    list = File.read(script_mods_list).split("\n")
    list.each { |mod| "Mod `#{mod}` does not exists" unless script_mod_exists?(script_mods) }
    list.each { |mod| _load_script script_mods }
  end

  # TODO
  def _load_script(mod)
    @sandbox.load(mod)
  end

  # TODO
  def _load_object(mod)
    @models.load(mod)
  end
end
