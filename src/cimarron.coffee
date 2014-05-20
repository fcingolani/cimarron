http        = require 'http'

connect     = require 'connect'
portfinder  = require 'portfinder'
_           = require 'underscore'


defaults =
  host: '0.0.0.0'
  port: 8000

  open_browser:   true
  enable_header:  true
  enable_logging: true

  routes: {'/': '.'}

  middlewares: []

_server_url = (host, port)->
  if host is '0.0.0.0'
    host = '127.0.0.1'

  "http://#{host}:#{port}"

_listen = (app, args...)->
  server = http.createServer app
  server.listen.apply server, args

_display_header = (host, port)->
  chalk = require 'chalk'

  server_url = _server_url host, port
  interrupt_key = "Ctrl+C"

  console.log """
              
                  ___ /\\_\\    ___ ___      __     _ __   _ __   ___     ___    
                 /'___\\/\\ \\ /' __` __`\\  /'__`\\  /\\`'__\\/\\`'__\\/ __`\\ /' _ `\\  
                /\\ \\__/\\ \\ \\/\\ \\/\\ \\/\\ \\/\\ \\L\\.\\_\\ \\ \\/ \\ \\ \\//\\ \\L\\ \\/\\ \\/\\ \\ 
                \\ \\____\\\\ \\_\\ \\_\\ \\_\\ \\_\\ \\__/.\\_\\\\ \\_\\  \\ \\_\\\\ \\____/\\ \\_\\ \\_\\
                 \\/____/ \\/_/\\/_/\\/_/\\/_/\\/__/\\/_/ \\/_/   \\/_/ \\/___/  \\/_/\\/_/


                  Listening on #{chalk.yellow server_url}
                  Press #{chalk.red interrupt_key} to stop the server

              """

_open_browser = (host, port)->
  opener = require 'opener'
  opener _server_url host, port

_find_port = (port, callback)->
  portfinder.basePort = port
  portfinder.getPort (err, free_port)=>
    callback free_port

class Cimarron

  constructor: (config)->
    if config?
      @load_config config

    _.defaults this, defaults

  load_config: (config)->
    _.extend this, config

  start: ()->

    app = connect()

    middlewares = @middlewares

    if @enable_logging
      middlewares.unshift [ connect.logger() ]

    for path, descriptor of @routes
      middlewares.push [path, connect.static(descriptor)]

    for middleware in middlewares
      app.use.apply app, middleware 

    
    _find_port @port, (free_port)=>

      _listen app, free_port, @host, ()=>

        if @enable_header
          _display_header @host, free_port

        if @open_browser
          _open_browser @host, free_port

instance = new Cimarron

module.exports = instance