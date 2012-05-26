require 'socket'
require 'openssl'
require 'base64'
require 'digest'

# Read public and private key from files
pub = OpenSSL::PKey::RSA.new(File.read("./pubkey.pem"))
priv = OpenSSL::PKey::RSA.new(File.read("./privkey.pem"),'1234')
user = 'andis'
cipher = Base64.encode64(Digest::SHA256.new.digest user)

clientSession = TCPSocket.new( "localhost", 1337 )
#Client requesting to authenticate. Sends hash of username
clientSession.puts cipher
  while !(clientSession.closed?) && (serverMessage = clientSession.gets)
    #Getting response messages from server
    response = serverMessage.gsub("___", "\n")
    #if the response is the challenge message
    if response.include?("CHALLENGE: ")
      puts "Challenge Accepted!"
      response = response.gsub("CHALLENGE: ", "")
      #Decrypt challenge with user's private key
      challenge = priv.private_decrypt(Base64.decode64(response))
      #The random challenge gets hashed ...
      proof = Base64.encode64(Digest::SHA256.new.digest challenge)
      # ... aaaand back to the server
      clientSession.puts proof
    end
    # If the user is authenticated
    if response.include?("User Authenticated.")
      puts "You have been successfully authenticated"
    end
    # If the user is NOT authenticated
    if response.include?("Could not authenticate.")
      puts "You could not be authenticated."
    end
    # If the response is "Goodbye" close the connection
    if response.include?("Goodbye")
      puts "log: closing connection"
      clientSession.close
    end
  end

