http = require 'http'

module.exports = class Streamer
  constructor: (@url, @chunkSeparator='\n') ->

  # Store the stream content in a string.
  content: ''

  # Make the request and listen to its events.
  init: (reinitializing = no) ->
    console.log """
      Initializing #{@constructor.name} for #{@url}"
      #{new Array(80).join '='}
    """ unless reinitializing
    request = http.get @url, (response) =>
      @_listenTo response, event for event in ['data', 'end']
    @_listenTo request, event for event in ['error', 'end']

  # Handle events with a method from this class of the same name.
  _listenTo: (emitter, eventName) ->
    emitter.on eventName, => this[eventName].apply this, arguments

  # On error, log and re-initialize.
  error: (error) ->
    console.log """
      #{new Array(80).join '#'}
      Got error: #{error.message}"
      #{new Array(80).join '#'}
    """
    @init yes

  # If the stream ends for some reason, re-initialize.
  end: -> @init yes

  # When we get data, check if we have a whole chunk.
  data: (chunk) ->
    @content += chunk
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

