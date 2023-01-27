var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
var workerSchema = new Schema({
    name: {
        type: String,
        require: true
    },
    role: {
        type: String,
     
    },
    password: {
        type: String,
        require: true
    },
  phonenumber:{
      type: String,
  },
  region:{
    type:String,
},  about:{
    type:String,
},
  category:{
    type: Array, 
},
time:{
    type: Array, 
},
rating:{
    type:Number
},
})

workerSchema.pre('save', function (next) {
    var worker = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function (err, salt) {
            if (err) {
                return next(err)
            }
            bcrypt.hash(worker.password, salt, function (err, hash) {
                if (err) {
                    return next(err)
                }
                worker.password = hash;
                next()
            })
        })
    }
    else {
        return next()
    }
})

workerSchema.methods.comparePassword = function (passw, cb) {
    bcrypt.compare(passw, this.password, function (err, isMatch) {
        if(err) {
            return cb(err)
        }
        cb(null, isMatch)
    })
}

module.exports = mongoose.model('Worker', workerSchema)