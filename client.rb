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
    response = serverMessage.gsub("___", "\n")
    if response.include?("CHALLENGE: ")
      puts "Challenge Accepted!"
      response = response.gsub("CHALLENGE: ", "")
      challenge = priv.private_decrypt(Base64.decode64(response))
      proof = Base64.encode64(Digest::SHA256.new.digest challenge)
      clientSession.puts proof
    end
    if response.include?("User Authenticated.")
      puts "You have been successfully authenticated"
    end
    if response.include?("Could not authenticate.")
      puts "You could not be authenticated."
    end
    if response.include?("Goodbye")
      puts "log: closing connection"
      clientSession.close
    end
  end

