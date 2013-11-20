require 'coffee-script'
Fetcher = require './fetcher.coffee'

module.exports = class Streamer extends Fetcher

  # Reddit Analytics sends individual comments chunked by newlines.
  chunkSeparator: '\n'

  # If the stream ends for some reason, re-initialize.
  end: -> @init yes

  # When we get the data, check if we have a whole chunk.
  data: (chunk) ->
    super chunk
    if @content.indexOf @chunkSeparator isnt -1 then @handleChunks()

  # Handle every comment we've got.
  handleChunks: ->
    chunks = @content.split @chunkSeparator
    @content = chunks.pop()
    try
      @handleChunk JSON.parse(comment) for comment in chunks
    catch error
      @error error
      @content = chunks.join('') + @content
      @init yes

  # Overwrite this method to handle the chunks as you wish.
  handleChunk: (comment) ->

