(function() {
  var Mongoose, auth, config, cs, express, server;
  express = require('express');
  cs = require('coffee-script');
  server = express.createServer();
  Mongoose = require('mongoose');
  config = require('/home/node/playsets_config').cfg;
  auth = require('connect-auth');
  server.configure(function() {
    server.use(express.logger());
    server.use(express.bodyParser());
    server.use(express.methodOverride());
    server.use(express.cookieParser());
    server.use(express.static(__dirname + '/static'));
    server.use(express.session({
      secret: config.session_secret
    }));
    return server.use(auth([
      auth.Twitter({
        consumerKey: config.twitter_key,
        consumerSecret: config.twitter_secret,
        callback: 'http://crumpets.playsets.no.de:3000/auth/twitter'
      }), auth.Facebook({
        appId: config.facebook_id,
        appSecret: config.facebook_secret,
        callback: config.facebook_callback
      })
    ]));
  });
  server.configure('production', function() {
    process.env.server = 'PRODUCTION';
    return server.listen(80);
  });
  server.configure('development', function() {
    process.env.server = 'DEVELOPMENT';
    server.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
    return server.listen(3000);
  });
  server.configure('test', function() {
    process.env.server = 'TEST';
    return module.exports.server = server;
  });
  server.set('views', __dirname + '/views');
  server.set('view engine', 'jade');
  server.get('/', function(req, res) {
    return res.redirect('/playsets');
  });
  module.exports.server = server;
  require('./db');
  require('./models/account');
  require('./models/playset');
  require('./controllers/accounts');
  require('./controllers/playsets');
}).call(this);
