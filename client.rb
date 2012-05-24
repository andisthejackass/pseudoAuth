require 'socket'
require 'openssl'
require 'base64'

pub = OpenSSL::PKey::RSA.new(File.read("./pubkey.pem"))
priv = OpenSSL::PKey::RSA.new(File.read("./privkey.pem"),'1234')
user = 'andis'
cipher = Base64.encode64(pub.public_encrypt(user))
clear = priv.private_decrypt(Base64.decode64(cipher))

clientSession = TCPSocket.new( "localhost", 1337 )
puts "log: starting connection"
puts "log: saying hello"
clientSession.puts "Client: Hello Server World!\n"
  while !(clientSession.closed?) && (serverMessage = clientSession.gets)
    puts serverMessage
    if serverMessage.include?("Goodbye")
      puts "log: closing connection"
      clientSession.close
    end
  end

