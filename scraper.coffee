require 'coffee-script'
Fetcher = require './fetcher.coffee'

module.exports = class Scraper extends Fetcher

  # Once the request ends, parse the content.
  end: ->
    @handleResponse @content

  # Handle every comment we've got.
  handleResponse: (json) ->
    comments = JSON.parse(json).data.children
    @handleChunk comment.data for comment in comments

