server = require('../server').server
assert = require('assert')
Mongoose = require('mongoose')
db = Mongoose.connect('mongodb://localhost/test-playsets-test ')
Playset = db.model('Playset')

exports['GET /'] = ->
  assert.response server, 
    {
      url: '/'
    },
    {
      status: 302
    }

exports['GET /playsets'] = ->
  assert.response server, 
    {
      url: '/playsets'
    },
    {
      status: 200
    }
  
exports['GET /playsets/new'] = ->
  assert.response server,
    {
      url: '/playsets/new'
    },
    {
      status: 200
    }
    
exports['POST /playsets'] = ->
  assert.response server,
  {
    url: '/playsets',
    body: '{ "playset": { "title": "foo" } }',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  },
  {
    status: 302 
  },
  (res) ->
    assert.match res.headers.location, /^http:\/\/undefined\/playsets\/[a-z0-9]+$/
     
exports['GET /playsets/quack 404s'] = ->
  assert.response server,
    {
      url: '/playsets/quack'
    },
    {
      status: 404
    }
    
exports['GET /playsets/:id'] = ->
  Playset.findOne (err, playset) ->
    assert.response server,
      {
        url: '/playsets/' + playset._id
      },
      {
        status: 200
      }