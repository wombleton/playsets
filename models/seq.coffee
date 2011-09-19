db = require('../db').db
mongoose = require('mongoose')
Schema = mongoose.Schema

SeqSchema = new Schema(
  seq: Number
)

mongoose.model('Seq', SeqSchema)
Seq = db.model('Seq')

module.exports.get_key = (seq, callback) ->
  Seq.collection.findAndModify(
    _id: seq
    [[ '_id', 'asc' ]]
    {
      $inc:
        seq: 1
    }
    {
      new: true
      upsert: true
    }
    (err, updated) ->
      callback(updated.seq)
  )
