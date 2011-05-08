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
    body: 'playset[title]=foo',
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }
  },
  {
    status: 302
  },
  (res) ->
    assert.eql 'http://undefined/playsets/foo', res.headers.location