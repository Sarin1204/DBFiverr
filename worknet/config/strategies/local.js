/**
 * Created by vipul on 4/27/2016.
 */
/**
 * Created by sarin on 10/21/15.
 */


var passport = require('passport'),
    LocalStrategy = require('passport-local').Strategy,
    sequelize = require("../../config/sequelize").getSequelize;

module.exports = function() {
    passport.use(new LocalStrategy({
        usernameField : 'email',
        passwordField : 'password'
    },function(email, password, done){
        var query = "select [dbo].[udf_authenticate](:email,:password)";
        sequelize.query(query, { replacements: {email: email, password: password }, type: sequelize.QueryTypes.SELECT})
            .then(function(ret) {
                console.log("[dbo].[udf_authenticate] executed"+JSON.stringify(ret));
                console.log("ret == "+JSON.stringify(ret));
                if (ret[0][""] == 1){
                    var query = "select email_id, firstname, lastname, totalcredit from Person where email_id = :email";
                    sequelize.query(query, { replacements: {email: email }, type: sequelize.QueryTypes.SELECT})
                        .then(function(person) {
                            console.log("Authentication successful"+JSON.stringify(person));
                            return done(null, person[0]);
                        })
                }
                else{
                    return done(null, false, {
                        message: 'Invalid Password'
                    });
                }
                
            })
        
    }));
};