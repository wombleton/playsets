Mongoose = require('mongoose')

SeqSchema = new Mongoose.Schema
  seq: Number

Mongoose.model 'Seq', SeqSchema

Seq = undefined

exports.init = (module) ->
  Seq = module
  
exports.getSequence = (sequence) -> ->
  Seq.collection.findAndModify(
    {
      query: {
        _id: sequence
      } 
      update: {
        $inc: {
          seq: 1
        } 
      }
      new: true
    },
    (err, doc) ->
      console.log doc    
  )
  return;