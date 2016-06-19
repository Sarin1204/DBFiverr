/**
 * Created by starn on 4/28/2016.
 */

var sequelize = require("../../config/sequelize").getSequelize;

exports.getTopServices = function(req, res, next) {
    console.log('inside getTopRequests controller'+JSON.stringify(req.user[0]))
    user = req.user[0];
    //var  email = "john.doe@gmail.com"
    var email = user.email_id;
        title = req.body.title,
            description = req.body.description,
            category = req.body.category;



    // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
    var query = "exec dbo.sp_service :email, :category, :title, :description,";
    sequelize.query(query, { replacements: {email: email }, type: sequelize.QueryTypes.SELECT})
        .then(function(new_requests,error) {
            console.log(JSON.stringify("exec dbo.sp_toprequests successful"+JSON.stringify(new_requests)));
            return res.json({"new_requests":new_requests});
            console.log("error is "+JSON.stringify(error))
        })
};

exports.submitService = function(req, res, next){
    console.log("req body ==>"+JSON.stringify(req.body));
    console.log("req category " + req.body.category);
    var email = user.email_id;
    title = req.body.title,
        description = req.body.description,
        category = 'bcd';
    var query = "exec dbo.sp_service :email,:category, :title, :description";
    sequelize.query(query, { replacements: {email: email, title: title, description: description, category: category }, type: sequelize.QueryTypes.SELECT})
        .then(function(response,error) {
            console.log(JSON.stringify("exec dbo.sp_service successful"+JSON.stringify(response)));
            return res.json({"response":response});
            console.log("error is "+JSON.stringify(error))
        })
}