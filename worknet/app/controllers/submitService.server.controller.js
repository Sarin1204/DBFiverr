/**
 * Created by starn on 4/29/2016.
 */

var sequelize = require("../../config/sequelize").getSequelize;


exports.signout = function(req, res) {
    req.logout();
    res.redirect('/');
};

exports.signup = function(req, res, next) {
    console.log('inside server controller submitService')
    if (!req.user) {
        var  email = req.body.email,
            title = req.body.title,
            description = req.body.description,
            category = req.body.category

        // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
        var query = "exec dbo.sp_service :email, :title, :description, :category";
        sequelize.query(query, { replacements: {email: email, title: title, description: description, category: category }, type: sequelize.QueryTypes.SELECT})
            .then(function(success) {
                console.log(JSON.stringify("exec dbo.sp_service successful"));
                res.redirect('/dashboard')
            })

    } else {
        return res.redirect('/');
    }
};