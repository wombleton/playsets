easyoauth = require('easy-oauth')
config = require('./config').cfg,

getAuth = (req) ->
  details = req.getAuthDetails()
  user = details.user
  if user
    twitterish = user.user_id and user.username
    facebookish = user.name and user.link
  
    if twitterish
      return
        name: user.username
        url: "https://twitter.com/#{user.username}"
    else if facebookish
      return
        name: user.name
        url: user.link
  else
    return undefined
    
