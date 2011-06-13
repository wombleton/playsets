express = require('express')
cs = require('coffee-script')
server = express.createServer()
_ = require('underscore')
Mongoose = require('mongoose')
db = undefined

server.configure ->
  server.use express.logger()
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use express.cookieParser()
  server.use express.static __dirname + '/static'
  
  
server.configure 'production', ->
  db = Mongoose.connect 'mongodb://localhost/playsets'
  server.listen 80
  
server.configure 'development', -> 
  db = Mongoose.connect 'mongodb://localhost/playsets'
  server.use express.errorHandler {
    dumpExceptions: true,
    showStack: true
  }
  server.listen 3000
  
server.configure 'test', ->
  db = Mongoose.connect('mongodb://localhost/playsets-test')
  module.exports.server = server

server.set 'views', __dirname + '/views'
server.set 'view engine', 'jade'

user = require './users'
User = db.model 'User'
users.init server, User

playsets = require './playsets'
Playset = db.model 'Playset'

playsets.init  server, Playset
