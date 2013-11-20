require 'coffee-script'
Fetcher = require './fetcher.coffee'
FS = require 'fs'

module.exports = class Scraper extends Fetcher

  # How many minutes to wait in between scrapings.
  minutes: 2

  # Once the request ends, parse the content.
  end: ->
    @handleResponse @content
    @content = ''
    setTimeout ( => @init() ), 1000 * 60 * @minutes

  latestId:
    logFile: './log.json'
    get: ->
      if FS.existsSync @logFile
        fileContents = FS.readFileSync @logFile, encoding: 'utf8'
        JSON.parse(fileContents).latestId
      else
        null
    set: (id) ->
      FS.writeFileSync @logFile, """
        {
          "latestId": "#{id}"
        }
      """, encoding: 'utf8'

  # Handle every comment we've got.
  handleResponse: (json) ->
    # Note: Reddit returns things in reverse chronological order
    comments = JSON.parse(json).data.children
    latestId = @latestId.get()

    for comment in comments
      # Once we reach the latest ID, stop.
      if latestId and comment.data.id is latestId then break
      @handleChunk comment.data

    # Log the first ID as the latest.
    @latestId.set comments[0].data.id

