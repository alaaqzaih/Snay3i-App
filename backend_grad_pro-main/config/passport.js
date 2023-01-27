var JwtStrategy = require('passport-jwt').Strategy
var ExtractJwt = require('passport-jwt').ExtractJwt
var Worker = require('../models/workers')

var User = require('../models/user')
var config = require('./dbconfig')
var Manager = require('../models/manager')
module.exports = function (passport) {
    var opts = {}
    
    opts.secretOrKey = config.secret
    opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme('jwt')

    passport.use(new JwtStrategy(opts, function (jwt_payload, done) {
      //console.log(jwt_payload.find("worker"))
      /*  if(jwt_payload.)
        console.log("hi");
        console.log(jwt_payload.User)*/
       if( jwt_payload.find("worker"))
       { //console.log("true");
        Worker.find({
            id: jwt_payload.id
        }, function (err,worker) {
                if (err) {
                    return done(err, false)
                }
                if (worker) {
                    return done(null, worker)
                }

                else {
                    return done(null, false)
                }
        }
        )
    }
    else if(jwt_payload.find("user"))
    { 
        User.find({
            id: jwt_payload.id
        }, function (err, user) {
                if (err) {
                    return done(err, false)
                }
                if (user) {
                    return done(null, user)
                }

                else {
                    return done(null, false)
                }
        }
        )

    }
    else if(jwt_payload.find("manager"))
    { 
        Manager.find({
            id: jwt_payload.id
        }, function (err, manager) {
                if (err) {
                    return done(err, false)
                }
                if (manager) {
                    return done(null, manager)
                }

                else {
                    return done(null, false)
                }
        }
        )

    }
}
    
    ))

  
}