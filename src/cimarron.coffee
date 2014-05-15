http        = require 'http'

connect     = require 'connect'
chalk       = require 'chalk'
portfinder  = require 'portfinder'
opener      = require 'opener'

config = require process.cwd() + '/cimarron.json'

app = connect()

app.use connect.logger()

server_host = process.env.SERVER_HOST || config.host || '0.0.0.0'
server_port = process.env.SERVER_PORT || config.port

server_routes = config.routes || { "/": "." }

for path, descriptor of config.routes
  app.use path, connect.static(descriptor)

listen = (port)->

  http.createServer app
    .listen port, server_host, ()->

      if server_host is '0.0.0.0'
        server_host = '127.0.0.1'

      server_url = "http://#{server_host}:#{port}"
      interrupt_key = "Ctrl+C"

      console.log """
                  Listening on #{chalk.yellow server_url}
                  Press #{chalk.red interrupt_key} to stop the server
                  """

      opener server_url

if server_port?
  listen server_port
else
  portfinder.getPort (err, free_port)->
    listen free_port