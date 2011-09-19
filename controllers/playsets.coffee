server = require('../app')
playset = require('../models/playset')
Playset = playset.Playset
dateformat = require('dateformat')
flow = require('flow')
_ = require('underscore')

server.get('/playsets.json', (req, res) ->
  start = req.query.start
  limit = req.query.limit or 5
  Playset.find()
      .limit(limit)
      .skip(start)
      .desc('updated')
      .run (err, playsets) ->
        res.charset = 'utf-8'
        res.contentType('application/json')
        Playset.count (countErr, count) ->
          if err or countErr
            res.send(message: "Could not get playset list: #{err}")
          else
            res.send(
              success: true
              playsets: playsets
              totalCount: count
            )
)

server.post('/playsets', (req, res) ->
  playset = new Playset(
    title: req.body?.title
  )
  playset.save (err) ->
    res.charset = 'utf-8'
    res.contentType('application/json')
    if err
      res.send(message: 'Could not save playset.')
      res.status = 500
    else
      res.send(playset)
)
