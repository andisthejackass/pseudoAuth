require 'socket'
require 'openssl'
require 'base64'
require 'digest'

pub = OpenSSL::PKey::RSA.new(File.read("./pubkey.pem"))
priv = OpenSSL::PKey::RSA.new(File.read("./privkey.pem"),'1234')
user = 'andis'
cipher = Base64.encode64(Digest::SHA256.new.digest user)

clientSession = TCPSocket.new( "localhost", 1337 )
clientSession.puts cipher
  while !(clientSession.closed?) && (serverMessage = clientSession.gets)
    response = serverMessage
    if response.include?("CHALLENGE: ")
      puts "Challenge Accepted!"
    end
    if response.include?("Goodbye")
      puts "log: closing connection"
      clientSession.close
    end
  end

