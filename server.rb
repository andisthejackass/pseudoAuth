require 'socket'
require 'rubygems'
require 'active_record'
require 'yaml'
require_relative 'active_record_init.rb'


puts User.first.username

puts "Starting up server..."
server = TCPServer.new(1337)
while (session = server.accept)
 Thread.start do
   puts "log: Connection from #{session.peeraddr[2]} at
          #{session.peeraddr[3]}"
   puts "log: got input from client"
   input = session.gets
   puts input
   session.puts "Server: Welcome #{session.peeraddr[2]}\n"
   puts "log: sending goodbye"
   session.puts "Server: Goodbye\n"
 end
end
