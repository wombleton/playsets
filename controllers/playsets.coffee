server = require('../app')
playset = require('../models/playset')
Playset = playset.Playset
dateformat = require('dateformat')
flow = require('flow')
_ = require('underscore')

server.get('/playsets', (req, res) ->
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

onError = (req, res) ->
  res.status = 500
  res.send(message: 'Update failed.')

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

valid_params = (key, list, list_index, sublist_index = 1) ->
  return false unless _.isNumber(Number(key))
  return false unless _.include('objects locations needs relationships'.split(' '), list)
  return false unless 1 <= list_index <= 6
  return false unless 1 <= sublist_index <= 6
  true

server.put('/playsets/:key/:list/:list_index', (req, res) ->
  res.charset = 'utf-8'
  res.contentType('application/json')

  { key, list, list_index } = req.params
  name = req.body?.name
  Playset.findOne( key: key )
    .run (err, playset) ->
      if err or not name or not valid_params(key, list, list_index)
        onError(req, res)
      else
        playset[list][list_index].name = name
        playset.save (err, result) ->
          if err
            onError(req, res)
          else
            res.send(result)
)

server.put('/playsets/:key/:list/:list_index/:sublist_index', (req, res) ->
  res.charset = 'utf-8'
  res.contentType('application/json')

  { key, list, list_index, sublist_index } = req.params
  name = req.body?.name
  Playset.findOne( key: key )
    .run (err, playset) ->
      if err or not name or not valid_params(key, list, list_index, sublist_index)
        onError(req, res)
      else
        playset[list][list_index][sublist_index] = name
        playset.save (err, result) ->
          if err
            onError(req, res)
          else
            res.send(result)
)

server.put('/playsets/:key', (req, res) ->
  res.charset = 'utf-8'
  res.contentType('application/json')

  key = req.params.key
  { instant_setup, pitch, summary, title } = req.body
  Playset.findOne( key: key )
    .run (err, playset) ->
      if err or (not instant_setup? and not pitch and not summary and not title)
        onError(req, res)
      else
        if instant_setup?
          playset.instant_setup = instant_setup
        if pitch?
          playset.pitch = pitch
        if summary?
          playset.summary = summary
        if title?
          playset.title = title
        playset.save (err, result) ->
          if err
            onError(req, res)
          else
            res.send(result)
)
