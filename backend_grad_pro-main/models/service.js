var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
var servSchema = new Schema({
    catname: {
        type: String,
        require: true
    },
    service: {
        type: String, 
        require: true
    },
    description: {
        type: String,
       
    },
    price:{
      type: String,
    },
    estimatedTime:{
      type: Number,
    },
    role: {
    type: String,
 
     },
     Img: {
        type: String,
       // require: true
    },

})

module.exports = mongoose.model('Serv', servSchema)



