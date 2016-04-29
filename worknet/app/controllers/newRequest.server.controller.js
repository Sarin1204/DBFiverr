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

