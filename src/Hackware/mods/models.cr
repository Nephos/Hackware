class Mods::Models
  class ModObject
    JSON.mapping(
      activities: Array(Core::Model::Activity)?,
      components: Array(Core::Model::Component)?,
      files: Array(Core::Model::File)?,
      machines: Array(Core::Model::Machine)?,
      skills: Array(Core::Model::Skill)?,
    )
  end

  getter models : Array(Core::Model)
  getter list : Array(String)

  def initialize(@models = Array(Core::Model).new)
    @list = Array(String).new
  end

  # Load a new mod.
  # Add the path of the mod to the list of the loaded mods,
  # then load the json into a list of models.
  def load(path : String)
    path = File.expand_path(path)
    raise "No such file (#{path})" unless File.exists? path
    @list << path
    _load_json_at_path(path)
  end

  # :nodoc:
  private def _load_json_at_path(path : String)
    mod_code = File.read(path)
    mod_name = File.basename(path).split(".").first
    raise "Invalid Mod file name (#{mod_name})" unless mod_name =~ /^[a-zA-Z][a-zA-Z0-9_-]*$/

    objects = ModObject.from_json mod_code

    activities = objects.activities
    components = objects.components
    files = objects.files
    machines = objects.machines
    skills = objects.skills

    activities.each { |obj| models << obj } if activities
    components.each { |obj| models << obj } if components
    files.each { |obj| models << obj } if files
    machines.each { |obj| models << obj } if machines
    skills.each { |obj| models << obj } if skills
  end
end
