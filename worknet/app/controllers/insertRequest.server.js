/**
 * Created by ramyavarakantham on 4/29/2016.
 */

var sequelize = require("../../config/sequelize").getSequelize;




exports.newrequest = function(req, res, next) {
    console.log('inside server controller insertrequest')
    if (!req.user) {
        var  title = req.body.title,
            description = req.body.description,
            days_to_complete = req.body.days_to_complete,
            category_name = req.body.category_name

        // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
        var query = "exec dbo.sp_insert_new_request :title, :description, :days_to_complete, :category_name";
        sequelize.query(query, { replacements: {title: title, description: description, days_to_complete: days_to_complete, category_name: category_name }, type: sequelize.QueryTypes.SELECT})
            .then(function(success) {
                console.log(JSON.stringify("exec dbo.sp_insert_new_request successful"));
                res.redirect('/dashboard')
            })

    } else {
        return res.redirect('/');
    }
};