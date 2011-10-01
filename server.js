cs = require('coffee-script')
cluster = require('cluster')

if (process.env.NODE_ENV === 'production') {
  require('./app').listen(80);
} else {
  require('./app').listen(3000);
}
