easyoauth = require('easy-oauth')
Mongoose = require('mongoose')
Schema = Mongoose.Schema

User = new Schema
  name: String
  url:
    index: true
    type: String
  profile_pic: String
  service: String
  ts:
    default: -> new Date().getTime()
    index: true
    type: Number
  
Mongoose.model 'User', User

getAuth = (req) ->
  details = req.getAuthDetails()
  user = details.user
  if user
    twitterish = user.user_id and user.username
    facebookish = user.name and user.link
  
    if twitterish
      return {
        name: user.username
        service: 'twitter'
        url: "https://twitter.com/#{user.username}"
      }
    else if facebookish
      return {
        name: user.name
        service: 'facebook'
        url: user.link
      }
  else
    return undefined

    
module.exports.init = (server, User) ->
  saveSignup = (user) ->
    usr = new User(user)
    usr.save

  server.get '/authed/twitter/', (req, res) ->
    req.authenticate ['twitter'], (err, authed) ->
      if authed
        saveSignup getAuth(req)
        res.redirect '/'
      else
        res.end '<html><h1>Twitter authentication failed :( </h1></html>'
      
  server.get '/authed/facebook/', (req, res) ->
    req.authenticate ['facebook'], (err, authed) ->
    if authed
      saveSignup getAuth(req)
      res.redirect '/'
    else
      res.end '<html><h1>Facebook authentication failed :( </h1></html>'
