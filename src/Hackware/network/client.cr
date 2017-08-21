class Network::Client
  def self.handle(client_socket)
    client = new client_socket
    client.start
  end

  getter io : IO::Buffered

  # TODO: stuff with client
  def initialize(@io)
  end

  def start
    # loop { }
  end
end
