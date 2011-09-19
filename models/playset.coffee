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

SublistSchema = new Schema(
  name: [ String ]
)

ListSchema = new Schema(
  name: String
  sublists: [ SublistSchema ]
)

PlaysetSchema = new Schema(
  created:
    index: true
    type: Date
  img: String
  instant_setup: String
  pitch: String
  key: String
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
  get_key('playset', (key) ->
    playset.key = key
    playset.slug = slug("#{key}-#{playset.title}")
    debugger
    next()
  )
)

Mongoose.model('Playset', PlaysetSchema)
module.exports.Playset = db.model('Playset')
