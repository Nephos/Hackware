class Network::Client
  def self.handle(client_socket)
    client = new client_socket
    client.start
  end

  property io : IO::Buffered

  # TODO: stuff with client
  def initialize(@io)
  end

  # Loops to handle incoming requests
  def start
    while handle_incoming_request(@io.gets)
      # after request is handled
    end
    @io.close
  end

  # Handles a incoming packet. Returns true if the request is ok.
  def handle_incoming_request(request : String?) : Bool
    return false if request.nil?
    return _handle_request request
  end

  # TODO
  # Handles a request sent by a client.
  private def _handle_request(request : String) : Bool
    return false if request == "QUIT"
    return true
  end
end
