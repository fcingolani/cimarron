Liftoff = require 'liftoff'

CLI = new Liftoff
    name: 'cimarron'
    cwdOpt: 'cwd'
    requireOpt: 'require'

    extensions: require('interpret').extensions

  .on 'require', (name, module)->
    if name is 'coffee-script'
      module.register()

  .on 'requireFail', (name, err)->
    console.log 'Unable to load:', name, err

CLI.launch (env)->
  if(env.argv.verbose)
    console.log('LIFTOFF SETTINGS:', this)
    console.log('CLI OPTIONS:', env.argv)
    console.log('CWD:', env.cwd)
    console.log('LOCAL MODULES PRELOADED:', env.preload)
    console.log('EXTENSIONS RECOGNIZED:', env.validExtensions)
    console.log('SEARCHING FOR:', env.configNameRegex)
    console.log('FOUND CONFIG AT:',  env.configPath)
    console.log('CONFIG BASE DIR:', env.configBase)
    console.log('YOUR LOCAL MODULE IS LOCATED:', env.modulePath)
    console.log('LOCAL PACKAGE.JSON:', env.modulePackage)
    console.log('CLI PACKAGE.JSON', require('../package'))

  config =  if env.configPath? then require env.configPath else {}

  module_path = env.modulePath or 'cimarron'

  cimarron = require module_path

  cimarron.load_config config

  cimarron.start()