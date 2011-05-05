(function() {
  var Mongoose, Playset, cs, db, express, playsets, server, _;
  express = require('express');
  cs = require('coffee-script');
  server = express.createServer();
  _ = require('underscore');
  Mongoose = require('mongoose');
  db = void 0;
  server.configure(function() {
    server.use(express.logger());
    server.use(express.bodyParser());
    server.use(express.methodOverride());
    return server.use(express.static(__dirname + '/static'));
  });
  server.configure('production', function() {
    db = Mongoose.connect('mongodb://localhost/playsets');
    return server.listen(80);
  });
  server.configure('development', function() {
    db = Mongoose.connect('mongodb://localhost/playsets');
    server.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
    return server.listen(3000);
  });
  server.configure('test', function() {
    db = Mongoose.connect('mongodb://localhost/playsets-test');
    return module.exports.server = server;
  });
  server.set('views', __dirname + '/views');
  server.set('view engine', 'jade');
  playsets = require('./playsets');
  Playset = db.model('Playset');
  playsets.route(server, Playset);
}).call(this);
