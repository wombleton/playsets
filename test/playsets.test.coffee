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
      status: 200
    }

exports['/GET /new'] = ->
  assert.response server,
    {
      url: '/new'
    },
    {
      status: 200
    }