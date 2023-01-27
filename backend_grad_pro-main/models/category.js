var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var categorySchema = new Schema({
    name: {
        type: String,
        require: true
    },
    image:{
        type:String,
        require: true
    }
})
module.exports = mongoose.model('Category', categorySchema)