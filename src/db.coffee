levelup = require 'level-up'
levelws = require 'level-ws'

module.exports =(path) ->
  return levelws levelup path
