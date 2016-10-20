# Documentation for Brunch Plugins : https://github.com/brunch/brunch/blob/master/docs/plugins.md

fs = require 'fs'
path = require 'path';

module.exports = class RevReplaceBrunch

  brunchPlugin: true # required for all brunch plugins

# type: 'javascript|stylesheet|template' # Required for compilers, linters & optimizers
# extension: 'js|coffee|scss|...' # Filter out files by extension (Required for compilers, linters & optimizers)
# pattern: /\.js$/ # Filter out files by pattern (Required for compilers, linters & optimizers)

  constructor: (@config) ->
    @options = @config?.plugins?.revReplace ? {}

  onCompile: ->
    return unless @config.optimize # run during production mode only
    assetsPath = './' + path.join @config.paths.public, 'assets.json'
    indexPath = './' + path.join @config.paths.public, 'index.html'
    fs.readFile(assetsPath, 'utf8', (err, data) ->
      throw err if err
      assets = JSON.parse data
      fs.readFile(indexPath, 'utf8', (err, data) ->
        throw err if err
        for own asset, replacement of assets
          data = data.replace asset, replacement
        fs.writeFile(indexPath, data, 'utf8', (err) ->
          throw err if err
        )
      )
    )
