var server = require('../server').server,
    assert = require('assert'),
    Mongoose = require('mongoose'),
    db = Mongoose.connect('mongodb://localhost/test-playsets-test '),
    Playset = db.model('Playset');

exports['GET /'] = function() {
  assert.response(server, 
  {
    url: '/'
  },
  {
    status: 200
  });
}