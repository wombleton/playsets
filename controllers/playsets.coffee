server = require('../server').server
Playset = require('../models/playset').Playset
dateformat = require('dateformat')
flow = require('flow')
md = require('node-markdown').Markdown
MD_TAGS = 'b|em|i|li|ol|p|strong|ul|br|hr'
_ = require('underscore')
PAGE_SIZE = 50

server.get '/', (req, res) ->
  res.redirect '/playsets'
  console.log req.getAuthDetails()

server.get '/playsets', (req, res) ->
  Playset.find {}, (err, playsets) ->
    res.render 'playsets/playsets',
      locals:
        playsets: playsets

server.get '/playsets/new', (req, res) ->
  res.render 'playsets/new'
  
server.post '/playsets', (req, res) ->
  playset = new Playset req.body && req.body.playset
  playset.save (err) ->
    if err
      res.redirect '/playsets/new', { locals: { playset: playset } }
    else
      res.redirect playset.url
      
server.get '/playsets/:id', (req, res) ->
  Playset.findById req.params.id, (err, playset) ->
    if err or !playset
      res.render '404', {
        status: 404
      }
    else
      res.render 'playsets/show',
      {
        locals:
          playset: playset
      }
 
server.get '/playsets/:id/description/edit', (req, res) ->
  id = req.params.id
  Playset.findById req.params.id, (err, playset) ->
    if err or !playset
      res.render '404',
        status: 404
    else
      res.render 'playsets/form/description',
        locals:
          playset: playset

server.post '/playsets/:id/description/edit', (req, res) ->
  id = req.params.id
  property = req.params.property
  index = req.params.index
  
  Playset.findById req.params.id, (err, playset) ->
    if err or !playset
      res.render '404', {
        status: 404
      }
    else
      res.render 'playsets/form/description', {
        locals:
          playset: playset
      }
  
server.get '/playsets/:id/:property/:index', (req, res) ->
  id = req.params.id
  property = req.params.property
  index = req.params.index
  Playset.findById req.params.id, (err, playset) ->
    if err or !playset
      res.render '404', {
        status: 404
      }
    else
      res.render 'playsets/form/table', {
        locals:
          playset: playset
          property: property
          index: index
      }

server.post '/playsets/:id/:property/:index', (req, res) ->
  id = req.params.id
  property = req.params.property
  index = req.params.index
  table = req.body.table
  Playset.findById req.params.id, (err, playset) ->
    if err or !playset
      res.render '404', {
        status: 404
      }
    else
      playset[property][index] = table
      playset.save (err) ->
        res.redirect playset.url   