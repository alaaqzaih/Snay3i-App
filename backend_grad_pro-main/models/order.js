var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var orderSchema = new Schema({
    clientname: {
        type: String,
        require: true
    },
    category:{
        type:String,
        require: true
    },
    service:{
        type:String,
        require: true
    },
    time:{
        type:String,
        require: true
    },
    address:{
        type:Array,
        require: true
    },
    status:{
        type:String,
    },
    worker:{
        type:String,
    },
    rating:{
        type:Number,
    },durationTime:{
        type:Number,
    }
})
module.exports = mongoose.model('Order', orderSchema)