var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
var managerSchema = new Schema({
    
    name: {
        type: String,
        require: true
    },
    role: {
        type: String,
        require: true
    },
    password: {
        type: String,
        require: true
    },
  phonenumber:{
      type: String,
  },
})

managerSchema.pre('save', function (next) {
    var manager = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function (err, salt) {
            if (err) {
                return next(err)
            }
            bcrypt.hash(manager.password, salt, function (err, hash) {
                if (err) {
                    return next(err)
                }
                manager.password = hash;
                next()
            })
        })
    }
    else {
        return next()
    }
})

managerSchema.methods.comparePassword = function (passw, cb) {
    bcrypt.compare(passw, this.password, function (err, isMatch) {
        if(err) {
            return cb(err)
        }
        cb(null, isMatch)
    })
}

module.exports = mongoose.model('Manager', managerSchema)