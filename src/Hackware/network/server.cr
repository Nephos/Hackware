require "json"
require "socket"
require "openssl"

require "./client"

class Hw::Server
  class Network
    class Ssl
      JSON.mapping(key: String, cert: String)
    end

    JSON.mapping(port: UInt16, host: String, ssl: Ssl?)
  end

  JSON.mapping(network: Network, seed: UInt32)

  def self.init
    config_path = File.expand_path("./server.json")
    if !File.exists?(config_path)
      STDERR.puts "Error: no server configuration found in #{config_path}"
      exit(1)
    end

    Server.from_json File.read(config_path)
  end

  # Start the server.
  def start
    _start(@network.ssl)
  end

  private def _handle_client(socket)
    Hw::Client.handle socket
  end

  # Start the server with the SSL configuration.
  private def _start(ssl : Network::Ssl)
    context = _new_ssl_context(ssl)
    _loop_start(_new_server, context) do |client_socket|
      client_ssl = OpenSSL::SSL::Socket::Server.new client_socket, context
      spawn _handle_client client_ssl
    end
  end

  # Start the server without SSL.
  private def _start(ssl : Nil)
    _loop_start(_new_server) do |client_socket|
      spawn _handle_client client_socket
    end
  end

  # Create a new TCPServer.
  private def _new_server
    STDERR.puts "Listen on #{@network.host}:#{@network.port}"
    TCPServer.new(@network.host, @network.port)
  end

  # Create a new ssl context from the SSL configuration
  private def _new_ssl_context(ssl : Network::Ssl)
    context = OpenSSL::SSL::Context::Server.new
    context.private_key = ssl.key
    context.certificate_chain = ssl.cert
    context
  end

  private def _new_ssl_client(context, client_socket)
    OpenSSL::SSL::Socket::Server.new client, ssl_context
  end

  private def _loop_start(server_socket, context = nil, &block)
    loop do
      # STDERR.puts "Waiting for client"
      client_socket = (server_socket.accept?)
      if client_socket.nil?
        break
        STDERR.puts "accept returned nil"
      end
      yield client_socket
    end
  end
end
