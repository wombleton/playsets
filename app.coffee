express = require('express')
Mongoose = require('mongoose')
config = require('/home/node/playsets_config').cfg
auth = require('connect-auth')

server = express.createServer()
server.configure ->
  server.use express.logger()
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use express.cookieParser()
  server.use express.static("#{__dirname}/static")
  server.use express.session( secret: config.session_secret )
  server.use auth(
    [
      auth.Twitter(
        consumerKey: config.twitter_key
        consumerSecret: config.twitter_secret
        callback: 'http://crumpets.playsets.no.de:3000/auth/twitter'
      )
      auth.Facebook(
        appId: config.facebook_id
        appSecret: config.facebook_secret
        callback: config.facebook_callback
      )
    ]
  )

server.configure('production', ->
  process.env.server = 'PRODUCTION'
)

server.configure('development', ->
  process.env.server = 'DEVELOPMENT'
  server.use(express.errorHandler
    dumpExceptions: true
    showStack: true
  )
)

server.configure('test', ->
  process.env.server = 'TEST'
)

server.set('views', "#{__dirname}/views")
server.set('view engine', 'jade')

module.exports = server

#require('./models/account')
#require('./controllers/accounts')

require('./models/playset')
require('./controllers/playsets')

server.get('/', (req, res) ->
  res.render('layout')
)
