db = require('../db').db
Mongoose = require('mongoose')
Schema = Mongoose.Schema
_ = require 'underscore'
get_key = require('./seq').get_key

slug = (s) ->
  s?.replace(/\s+/g, '-').replace().replace(/[^a-zA-Z0-9-]/g, '').replace(/[-]+/g, '-').toLowerCase()

getOffset = (page = 1) ->
  page = 1 if page < 1
  (page - 1) * PAGE_SIZE

parseTags = (tags) ->
  tags = tags.join(' ') if _.isArray(tags)
  _.map _.compact(tags.split /\s+/), (tag) ->
    tag.replace /[^a-z0-9-_]/gi, ''

sublist =
  name:
    default: ''
    type: String
  1:
    default: ''
    type: String
  2:
    default: ''
    type: String
  3:
    default: ''
    type: String
  4:
    default: ''
    type: String
  5:
    default: ''
    type: String
  6:
    default: ''
    type: String

list =
  1: sublist
  2: sublist
  3: sublist
  4: sublist
  5: sublist
  6: sublist

PlaysetSchema = new Schema(
  created:
    index: true
    type: Date
  img: String
  instant_setup: String
  pitch: String
  key: String
  locations: list
  needs: list
  objects: list
  published:
    default: false
    type: Boolean
  relationships: list
  slug: String
  summary: String
  summaryimg: String
  tags:
    default: []
    index: true
    set: (tags) -> parseTags(tags)
    type: [ String ]
  title: String
  updated:
    index: true
    type: Date
  user: String
)

PlaysetSchema.pre('save', (next) ->
  playset = @
  if playset.key
    next()
  else
    get_key('playset', (key) ->
      playset.key = key
      playset.slug = slug("#{key}-#{playset.title}")
      next()
    )
)

Mongoose.model('Playset', PlaysetSchema)
module.exports.Playset = db.model('Playset')
