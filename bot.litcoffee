You should create a `config.json` file that contains the following keys:

- `username`: The username of the bot's account.
- `password`: The password of the bot's account.
- `author`: Your reddit username. This is put into the user agent string when
  communicating with the reddit API.

We then import this configuration, along with `package.json` and the npm module
[reddit-api](https://github.com/cha0s/reddit-api) that helps us talk to reddit.

    CONFIG  = require './config'
    PACKAGE = require './package'
    Reddit  = require 'reddit-api'

Next, we set up the bot with a user agent string in accordance with the [reddit
API rules](https://github.com/reddit/reddit/wiki/API#rules).

    reddit = new Reddit "#{PACKAGE.name}/#{PACKAGE.version} by #{CONFIG.authorReddit}"

So that we can see what's happening, we'll turn on logging.

    reddit.setIsLogging yes

We want the reddit bot to be rate-limited, so we don't run afoul of the rules.

    reddit.setDispatchMode 'limited'
    reddit.setLimiterFrequency '2500' # milliseconds

Log into the reddit API using values obtained from `config.json`.

    reddit.login CONFIG.username, CONFIG.password, (error) ->
      throw error if error?

Check if we have any orangereds. This isn't going to be in the final product,
it's just a convenient way to make sure we're communicating with the API.

    reddit.messages (error, message) ->
      throw error if error?
      console.log message

Once the queue has been drained, set the dispatch mode to immediate to quit.

    reddit.on 'drain', ->
      reddit.setDispatchMode 'immediate'

