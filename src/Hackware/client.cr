class Hw::Client
  def self.handle(client_socket)
    client = new client_socket
    client.start
  end

  getter socket : OpenSSL::SSL::Socket::Server | TCPSocket

  # TODO: stuff with client
  def initialize(@socket)
  end

  def start
    # loop { }
  end
end
