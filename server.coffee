express = require('express')
cs = require('coffee-script')
server = express.createServer()
Mongoose = require('mongoose')
config = require('/home/node/playsets_config').cfg
auth = require('connect-auth')

server.configure ->
  server.use express.logger()
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use express.cookieParser()
  server.use express.static __dirname + '/static'
  server.use express.session({ secret: config.session_secret })
  server.use auth([ 
    auth.Twitter
      consumerKey: config.twitter_key
      consumerSecret: config.twitter_secret
      callback: 'http://crumpets.playsets.no.de:3000/auth/twitter'
    auth.Facebook
      appId: config.facebook_id
      appSecret: config.facebook_secret
      callback: config.facebook_callback
  ])
  
server.configure 'production', ->
  process.env.server = 'PRODUCTION'
  server.listen 80
  
server.configure 'development', -> 
  process.env.server = 'DEVELOPMENT'
  server.use express.errorHandler
    dumpExceptions: true,
    showStack: true
  server.listen 3000
  
server.configure 'test', ->
  process.env.server = 'TEST'
  module.exports.server = server

server.set 'views', __dirname + '/views'
server.set 'view engine', 'jade'

server.get '/', (req, res) -> res.redirect('/playsets')

module.exports.server = server
require './db'

require './models/account'
require './models/playset'

require './controllers/accounts'
require './controllers/playsets'
