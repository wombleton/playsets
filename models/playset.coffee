db = require('../db').db
Mongoose = require('mongoose')
Schema = Mongoose.Schema

slug = (s) ->
  s?.replace(/\s+/g, '-').replace().replace(/[^a-zA-Z0-9-]/g, '').replace(/[-]+/g, '-').toLowerCase()

getOffset = (page = 1) ->
  page = 1 if page < 1
  (page - 1) * PAGE_SIZE

parseTags = (tags) ->
  tags = tags.join(' ') if _.isArray(tags)
  _.map _.compact(tags.split /\s+/), (tag) ->
    tag.replace /[^a-z0-9-_]/gi, ''    

tableDef = {
  header:
    type: String
    default: ''
  0: 
    type: String
    default: ''
  1: 
    type: String
    default: ''
  2: 
    type: String
    default: ''
  3: 
    type: String
    default: ''
  4: 
    type: String
    default: ''
  5: 
    type: String
    default: ''
} 

categoryDef = {
    0: tableDef
    1: tableDef
    2: tableDef
    3: tableDef
    4: tableDef
    5: tableDef
}

PlaysetSchema = new Schema {
  preamble: {
    type: String
  },
  instant: {
    type: String
  },
  relationships: categoryDef
  locations: categoryDef
  objects: categoryDef
  needs: categoryDef
  title: {
    type: String
  },
  meta: {
    id: Number,
    slug: String
  },
  ts: {
    'default': -> 
      new Date().getTime();
    ,
    index: true,
    type: Number
  },
  authors: String,
  tags: {
    'default': [],
    index: true,
    set: (tags) ->
      parseTags(tags);
    ,
    type: [ String ]
  }
}

PlaysetSchema.pre 'save', (next) ->
  this.meta.slug = this._id
  next()
  
PlaysetSchema.virtual('url').get ->
  '/playsets/' + this.meta.slug

PlaysetSchema.virtual('preamble_markdown').get -> 
  md(this.definition || '', MD_TAGS).replace(/>/g, '&gt;').replace(/</g, '&lt;')

PlaysetSchema.virtual('edit_url').get ->
  '/playsets/' + this._id + '/edit'

PlaysetSchema.virtual('id_url').get ->
  '/playsets/' + this._id

PlaysetSchema.virtual('date_display').get ->
  dateformat new Date(this.ts), 'dd mmm yyyy'

Mongoose.model 'Playset', PlaysetSchema

module.exports.Playset = db.model('Playset')