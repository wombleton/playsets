dateformat = require('dateformat')
flow = require('flow')
md = require('node-markdown').Markdown
MD_TAGS = 'b|em|i|li|ol|p|strong|ul|br|hr'
Mongoose = require('mongoose')
Schema = Mongoose.Schema
_ = require('underscore')
PAGE_SIZE = 50

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

Playset = new Schema {
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

Playset.pre 'save', (next) ->
  this.meta.slug = this._id
  next()
  
Playset.virtual('url').get ->
  '/playsets/' + this.meta.slug

Playset.virtual('preamble_markdown').get -> 
  md(this.definition || '', MD_TAGS).replace(/>/g, '&gt;').replace(/</g, '&lt;')

Playset.virtual('edit_url').get ->
  '/playsets/' + this._id + '/edit'

Playset.virtual('id_url').get ->
  '/playsets/' + this._id

Playset.virtual('date_display').get ->
  dateformat new Date(this.ts), 'dd mmm yyyy'

Mongoose.model 'Playset', Playset

module.exports.init = (server, Playset) ->
  server.get '/', (req, res) ->
    res.redirect '/playsets'
    console.log req.getAuthDetails()

  server.get '/playsets', (req, res) ->
    Playset.find {}, (err, playsets) ->
      res.render 'playsets/playsets',
        locals:
          playsets: playsets

  server.get '/playsets/new', (req, res) ->
    res.render 'playsets/new'
    
  server.post '/playsets', (req, res) ->
    playset = new Playset req.body && req.body.playset
    playset.save (err) ->
      if err
        res.redirect '/playsets/new', { locals: { playset: playset } }
      else
        res.redirect playset.url
        
  server.get '/playsets/:id', (req, res) ->
    Playset.findById req.params.id, (err, playset) ->
      if err or !playset
        res.render '404', {
          status: 404
        }
      else
        res.render 'playsets/show',
        {
          locals:
            playset: playset
        }
   
  server.get '/playsets/:id/description/edit', (req, res) ->
    id = req.params.id
    Playset.findById req.params.id, (err, playset) ->
      if err or !playset
        res.render '404', {
          status: 404
        }
      else
        res.render 'playsets/form/description', {
          locals:
            playset: playset
        }
    
  server.get '/playsets/:id/:property/:index', (req, res) ->
    id = req.params.id
    property = req.params.property
    index = req.params.index
    Playset.findById req.params.id, (err, playset) ->
      if err or !playset
        res.render '404', {
          status: 404
        }
      else
        res.render 'playsets/form/table', {
          locals:
            playset: playset
            property: property
            index: index
        }
  
  server.post '/playsets/:id/:property/:index', (req, res) ->
    id = req.params.id
    property = req.params.property
    index = req.params.index
    table = req.body.table
    Playset.findById req.params.id, (err, playset) ->
      if err or !playset
        res.render '404', {
          status: 404
        }
      else
        playset[property][index] = table
        playset.save (err) ->
          res.redirect playset.url   