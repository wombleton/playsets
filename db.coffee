Mongoose = require('mongoose')

if process.env.server is 'TEST'
  db = Mongoose.connect('mongodb://localhost/testplaysets')
else
  db = Mongoose.connect('mongodb://localhost/playsets')
  
module.exports.db = db
