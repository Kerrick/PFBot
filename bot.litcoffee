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

Courtesy of [Reddit Analytics](http://www.redditanalytics.com), we monitor all
the comments that are posted to the subreddits listed in the `listen.json` file
`subreddits` array.

    subreddits = LISTEN.subreddits.map (subreddit) -> subreddit.name
    url = "http://www.reddit.com/r/#{subreddits.join '+'}/comments.json"
    scraper = new Scraper url

# Comment Scraping

When we get a comment, we'll simply log it for now. _TODO_

    Scraper::handleChunk = (comment) ->
      console.log """
        Author: /u/#{comment.author}
        Subreddit: /r/#{comment.subreddit}
        Thread: "#{comment.link_title}"
        Content:
        #{comment.body}
        #{new Array(80).join '-'}
      """

Finally, we initialize the `scraper` so it can do its thing.

    scraper.init()

# Weekly Thread Posting

_TODO_

