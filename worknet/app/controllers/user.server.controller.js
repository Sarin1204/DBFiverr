/**
 * Created by vipul on 4/23/2016.
 */
var sequelize = require("../../config/sequelize").getSequelize;


exports.signout = function(req, res) {
    req.logout();
    res.redirect('/');
};

exports.signup = function(req, res, next) {
    console.log('inside server controller signup')
    if (!req.user) {
       var  email = req.body.email,
           password = req.body.password,
           firstname = req.body.firstname,
           lastname = req.body.lastname

       // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
        var query = "exec dbo.sp_insert_person :email, :password, :firstname, :lastname";
        sequelize.query(query, { replacements: {email: email, password: password, firstname: firstname, lastname: lastname }, type: sequelize.QueryTypes.SELECT})
            .then(function(success) {
                console.log(JSON.stringify("exec dbo.sp_insert_person successful"));
            res.redirect('/dashboard')
            })

    } else {
        return res.redirect('/');
    }
};