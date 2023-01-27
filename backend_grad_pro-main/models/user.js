var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
var userSchema = new Schema({
    
    name: {
        type: String,
        require: true,
        unique:true,
        
       // index: {unique: true,}
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
  region:{
    type:String,
},
address:{
    type:String,
},
  latitude:{
    type: Number
},
   longitude:{
    type: Number
},

})

userSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function (err, salt) {
            if (err) {
                return next(err)
            }
            bcrypt.hash(user.password, salt, function (err, hash) {
                if (err) {
                    return next(err)
                }
                user.password = hash;
                next()
            })
        })
    }
    else {
        return next()
    }
})

userSchema.methods.comparePassword = function (passw, cb) {
    bcrypt.compare(passw, this.password, function (err, isMatch) {
        if(err) {
            return cb(err)
        }
        cb(null, isMatch)
    })
}
var u=mongoose.model('User', userSchema)
u.createIndexes();
module.exports = u