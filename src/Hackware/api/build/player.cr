require "../api_build"

module ApiBuild::Player
  extend self

  macro list_players(world)
    {{world}}.sandbox.js_context.push_global_proc("list_players", 0) do |ptr|
      ctx = Duktape::Sandbox.new ptr
      ctx << {{world}}.persons.map { |id, person| [id.to_s, person.to_s] }.to_h
      ctx.call_success
    end
  end

  macro ask(world)
    {{world}}.sandbox.js_context.push_global_proc("ask", 2) do |ptr|
      ctx = Duktape::Sandbox.new ptr
      js_args = ApiBuild.read_js_args ctx, :interface, :question

      if js_args[:interface] == "stdin"
        STDOUT.puts js_args[:question]
        input = gets.to_s.chomp
        ctx << input
      else
        STDERR.puts "interface #{js_args[:interface]} failure"
        ctx << nil
      end

      ctx.call_success
    end
  end
end
