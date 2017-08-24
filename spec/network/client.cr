describe Network::Client do
  it "instanciate new client" do
    io = StringIO.new
    io.puts "HELLO"
    io.puts "USER AUTH : arthur poulet"
    io.puts "GET USER"
    io.puts "QUIT"
    cli = Network::Client.new io
    cli.handle_incoming_request(cli.io.gets)
  end
end
