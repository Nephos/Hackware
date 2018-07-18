require "../api_build"

module ApiBuild::Player
  extend self

  macro list_players(world)
    ApiBuild.create_function {{world}}.sandbox.js_context, "list_players" do |ctx, args|
      \{{ctx}} << {{world}}.persons.map { |id, person| [id.to_s, person.to_s] }.to_h
    end
  end
end
