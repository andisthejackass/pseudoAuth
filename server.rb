require 'socket'
require 'openssl'
require 'base64'
require 'rubygems'
require 'active_record'
require 'yaml'
require_relative 'active_record_init.rb'

puts "Server started ..."
server = TCPServer.new(1337)
while (session = server.accept)
  Thread.start do
    #puts "log: Connection from #{session.peeraddr[2]} at #{session.peeraddr[3]}"
    #Get encrypted username
    input = session.gets
    #Search in DB for username
    user = User.where(:username => input).first
    if user == nil
      puts "User could not be found."
    else
      puts "user: " + user.username
      pub = OpenSSL::PKey::RSA.new(user.pub)
      random = rand(100)
      puts random
      challenge = Base64.encode64(pub.public_encrypt(random.to_s))
      puts challenge
    end
    session.puts "Server: Goodbye\n"
  end
end
