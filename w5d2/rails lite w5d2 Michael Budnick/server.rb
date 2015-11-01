require 'webrick'

server = WEBrick::HTTPServer.new(:Port = 3000)

trap("INT") { server.shutdown }

server.start
