/**
 * Created by vipul on 4/27/2016.
 */

var sequelize = require("../../config/sequelize").getSequelize;

exports.getTopRequests = function(req, res, next) {
    console.log('inside server controller signup')
    if (!req.user) {
        var  email = "john.doe@gmail.com"
        var email = req.email_id

        // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
        var query = "exec dbo.sp_toprequests :email";
        sequelize.query(query, { replacements: {email: email }, type: sequelize.QueryTypes.SELECT})
            .then(function(new_requests) {
                console.log(JSON.stringify("exec dbo.sp_insert_person successful"+JSON.stringify(new_requests)));
                return res.json({"new_requests":new_requests});
            })

    } else {
        return res.status(500).send({ error: 'exec dbo.sp_toprequests did not work'+err });
    }
};