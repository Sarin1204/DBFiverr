/**
 * Created by vipul on 4/23/2016.
 */
var passport = require('passport')

module.exports = function(){

    passport.serializeUser(function(person, done){
        console.log("serial person == "+JSON.stringify(person));
        console.log(person.email_id)
        done(null, person.email_id);
    });

    passport.deserializeUser(function(email, done){
        console.log('deserial email == '+email);
        models.instance.parents.findOne({email : email}, function(err, parent){
            done(err, parent);
        });
    });
    require('./strategies/local.js')();
    //require('./strategies/facebook.js')();
};