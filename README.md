Cimarron is a zero-configuration http server. It's ideal for development and testing.

[![NPM version](https://badge.fury.io/js/cimarron.svg)](http://badge.fury.io/js/cimarron)


Installation
------------

Directly from NPM

    npm install cimarron -g

You can clone it from Github too:

    git clone https://github.com/fcingolani/cimarron.git
    cd cimarron
    npm install . -g
    
Usage
-----

`cd` into a directory, then run `cimarron`; a browser window will be open pointing to your recently started Web Server.

    cd DIRECTORY
    cimarron
    
Configuration
-------------

`cimarron` does not require any configuration to start serving your content. That doesn't mean it's not possible to configure it.

Configuration is done using a `Cimarronfile`, which can be one of two flavours:

1. Static configuration. Using JSON, YAML, or XML.
2. Dynamic configuration. Via JavaScript or CoffeeScript.

###Static Configuration

Create a `Cimarronfile.json` inside the directory you want to serve:

````json
{
    "host": "0.0.0.0",
    "port": 8000,
    "enable_header": true,
    "enable_logging": true,
    "routes": {
      "/": "."
    },
    "browse": [
        "/"
    ]
}
````

In fact those are the default values used when you don't create a `Cimarronfile`!

In case you want to add more routes, just add them to the routes array:

````json
{
    "routes": {
      "/": "./public",
      "/assets/": "./bower_components"
    }
}
````

Remember, it's not required to define every property, forementioned defaults will be used.

Options
-------

### host

Hostname which `cimarron` will listen to. ***Default: 0.0.0.0***.

### port

Port number which `cimarron` will listen to. In fact, it will search for a free port incrementally until it finds one, starting in the selected port. ***Default: 8000***.

### enable_header

If false, won't show the `cimarron` banner on start. ***Default: true***.

### enable_logging

If false, won't log requests to stdout. ***Default: true***.

### routes

An object to define the *mountpoints* of your application.

For example:

````json
{
    "routes": {
      "/": "./public",
      "/assets/": "./bower_components"
    }
}
````

### browse

An array of URLs to open automatically in your browser when `cimarron` starts. It will open each URL in a browser tab!
