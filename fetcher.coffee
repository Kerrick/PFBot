http = require 'http'

module.exports = class Fetcher
  constructor: (@url, @logging = yes) ->

  # Create standardized things for logs.
  _timestamp: -> "[#{new Date().toISOString()}]"
  _line: (character = '-', length = 80) -> new Array(length).join character

  # Store the response content in a string.
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

  # When we get data, add it to @content.
  data: (chunk) ->
    @content += chunk

