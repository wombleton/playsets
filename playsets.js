var dateformat = require('dateformat'),
    flow = require('flow'),
    md = require('node-markdown').Markdown,
    MD_TAGS = 'b|em|i|li|ol|p|strong|ul|br|hr',
    Mongoose = require('mongoose'),
    Schema = Mongoose.Schema,
    _ = require('underscore'),
    Category,
    Playset,
    Table,
    PAGE_SIZE = 50;

function slug(s) {
  return (s || '').replace(/\s+/g, '-').replace(/[^a-zA-Z0-9-]/g, '').replace(/[-]+/g, '-').toLowerCase();
}

function getOffset(page) {
  page = page || 1;
  if (page < 1) {
    page = 1;
  }
  return (page - 1) * PAGE_SIZE;
}

function parseTags(tags) {
  tags = _.isArray(tags) ? tags.join(' ') : tags || '';
  return _.map(_.compact(tags.split(/\s+/)), function(tag) {
    return tag.replace(/[^a-z0-9-_]/gi, '');    
  });
}

Category = new Schema({
  title: String,
  subcategories: [ String ]
});
Table = new Schema({
  title: String,
  categories: [ Category ]
});

Playset = new Schema({
  preamble: {
    type: String
  },
  instant: {
    type: String
  },
  tables: [ Table ],
  title: {
    type: String
  },
  meta: {
    slug: String
  },
  ts: {
    'default': function() {
      return new Date().getTime();
    },
    index: true,
    type: Number
  },
  authors: String,
  tags: {
    'default': [],
    index: true,
    set: function(tags) {
      return parseTags(tags);
    },
    type: [ String ]
  }
});

Playset.pre('save', function(next) {
  this.meta.slug = slug(this.condition);
  next();
});
Playset.virtual('url').get(function() {
  return '/playsets/' + this.meta.slug;
});

Playset.virtual('preamble_markdown').get(function() {
  return md(this.definition || '', MD_TAGS);
});

Playset.virtual('edit_url').get(function() {
  return '/playsets/' + this._id + '/edit';
});

Playset.virtual('id_url').get(function() {
  return '/playsets/' + this._id;
});
Playset.virtual('date_display').get(function() {
  return dateformat(new Date(this.ts), 'dd mmm yyyy');
});

Mongoose.model('Playset', Playset);

module.exports.route = function(server, Playset) {
};
