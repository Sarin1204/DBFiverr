/**
 * Created by ramyavarakantham on 4/28/2016.
 */

var sequelize = require("../../config/sequelize").getSequelize;

exports.getNewRequests = function(req, res, next) {
    console.log('inside new request server controller')
    if (!req.user) {
        var  email = "john.doe@gmail.com"
        //var email = req.email_id
        var category_name = req.category_name
        var title = req.title
        var description = req.description
        var days_to_complete = req.days_to_complete

        // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
        var query = "exec dbo.sp_insert_new_request :email :category_name :title :description :days_to_complete";
        sequelize.query(query, { replacements: {email: email  }, type: sequelize.QueryTypes.SELECT})
            .then(function(new_requests) {
                console.log(JSON.stringify("exec dbo.sp_insert_person successful"+JSON.stringify(new_requests)));
                return res.json({"new_requests":new_requests});
            })

    } else {
        return res.status(500).send({ error: 'exec dbo.sp_toprequests did not work'+err });
    }
};

exports.newrequest = function(req, res, next){
    console.log("req body ==>"+JSON.stringify(req.body));
    var email = user.email_id;
    title = req.body.title,
        description = req.body.description,
        category = 1,
        days_to_complete = req.body.days_to_complete;
    var query = "exec dbo.sp_insert_new_request :email, :category, :title, :description, :days_to_complete";
    sequelize.query(query, { replacements: {email: email, title: title, description: description, category: category, days_to_complete: days_to_complete }, type: sequelize.QueryTypes.SELECT})
        .then(function(response,error) {
            console.log(JSON.stringify("exec sp_insert_new_request successful"+JSON.stringify(response)));
            console.log("error is "+JSON.stringify(error))
            return res.json({"response":response});

        })
}

