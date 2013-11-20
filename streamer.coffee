http = require 'http'

module.exports = class Streamer
  constructor: (@url, @logging = yes, @chunkSeparator = '\n') ->

  # Create standardized things for logs.
  _timestamp: -> "[#{new Date().toISOString()}]"
  _line: (character = '-', length = 80) -> new Array(length).join character

  # Store the stream content in a string.
  content: ''

  # Make the request and listen to its events.
  init: (reinitializing = no) ->
    word = if reinitializing then "Reinitializing" else "Initializing"
    console.log """
      #{@_line '='}
      #{@_timestamp()} #{word} #{@constructor.name}
      #{@_line '='}
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
      #{@_line '#'}
      #{@_timestamp()} Got error: #{error.message}
      #{@_line '#'}
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

