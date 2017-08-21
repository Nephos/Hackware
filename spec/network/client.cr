describe Network::Client do
  it "instanciate new client" do
    io = StringIO.new
    cli = Network::Client.new io
  end
end
