require 'socket'
require 'rubygems'
require 'active_record'
require 'yaml'
require_relative 'active_record_init.rb'

puts "Starting up server..."
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
      pub = user.pub
      puts pub
    end
    session.puts "Server: Goodbye\n"
  end
end
