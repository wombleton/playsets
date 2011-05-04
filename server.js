var express = require('express'),
    server = express.createServer(),
    _ = require('underscore'),
    Mongoose = require('mongoose'),
    db;

server.configure(function() {
  server.use(express.logger());
  server.use(express.bodyParser());
  server.use(express.methodOverride());
  server.use(express.static(__dirname + '/static'))
});

server.configure('production', function() {
  db = Mongoose.connect('mongodb://localhost/playsets')
  server.listen(80);
});

server.configure('development', function() {
  db = Mongoose.connect('mongodb://localhost/playsets')
  server.use(express.errorHandler({
    dumpExceptions: true,
    showStack: true
  }));
  server.listen(3000);  
});

server.configure('test', function() {
  db = Mongoose.connect('mongodb://localhost/playsets-test')
  module.exports.server = server;
})
server.set('views', __dirname + '/views');
server.set('view engine', 'jade');

var playsets = require('./playsets'),
    Playset = db.model('Playset');

playsets.route(server, Playset);
