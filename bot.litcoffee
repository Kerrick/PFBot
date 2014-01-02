# Setup

## Require

You should create a `config.json` file that contains the following keys:

- `username`: The username of the bot's account.
- `password`: The password of the bot's account.
- `author`: Your reddit username. This is put into the user agent string when
  communicating with the reddit API.

We then import this configuration, along with npm modules and `json` files.

    require 'coffee-script' # So we can directly require coffeescript files
    CONFIG   = require './config'
    LISTEN   = require './listen'
    PACKAGE  = require './package'
    Scraper  = require './scraper'
    Reddit   = require 'reddit-api'
    _        = require 'lodash'

## Reddit API

Next, we set up the bot with a user agent string in accordance with the [reddit
API rules](https://github.com/reddit/reddit/wiki/API#rules).

    reddit = new Reddit "#{PACKAGE.name}/#{PACKAGE.version} by #{CONFIG.authorReddit}"
    reddit.setIsLogging yes
    reddit.setDispatchMode 'limited'
    reddit.setLimiterFrequency '2500' # milliseconds

Log into the reddit API using values obtained from `config.json`.

    reddit.login CONFIG.username, CONFIG.password, (error) ->
      throw error if error?

## Reddit Stream

Courtesy of [Reddit's API](http://www.reddit.com/dev/api), we monitor all
the comments that are posted to the subreddits listed in the `listen.json` file
`subreddits` array.

    subreddits = LISTEN.subreddits.map (subreddit) -> subreddit.name
    url = "http://www.reddit.com/r/#{subreddits.join '+'}/comments.json"
    scraper = new Scraper url

## Helper Methods

Lowercase, and remove everything but letters, numbers, and spaces from a string

    scrub = (string) -> string.toLowerCase().replace /[^a-z0-9 ]+/g, ''

# Comment Scraping

Handle a single comment.

    Scraper::handleChunk = (comment) ->
      console.log """
        Author: /u/#{comment.author}
        Subreddit: /r/#{comment.subreddit}
        Thread: "#{comment.link_title}"
        Content:
        #{comment.body}
        #{new Array(80).join '-'}
      """

Check the comment for any triggers.

      LISTEN.triggers
        .filter (trigger) ->
          comment.body.indexOf(trigger.value) isnt -1

Check triggered comments for any commands.

        .forEach (trigger) ->
          LISTEN.commands
            .filter (command) ->
              command.id in trigger.commands and
              scrub(comment.body).indexOf(scrub(command.value)) isnt -1

Handle commands using its responses.

            .forEach (command) ->
              LISTEN.responses
                .filter (response) ->
                  response.id in command.responses

We'll simply log that we should do something for now. _TODO_

                .forEach (response) ->
                  console.log """
                    Matched Trigger: #{trigger.value}
                    Matched Command: #{command.value}
                    Response:
                    #{response.value}
                    #{new Array(80).join '+'}
                  """


Finally, we initialize the `scraper` so it can do its thing.

    scraper.init()

# Weekly Thread Posting

_TODO_

