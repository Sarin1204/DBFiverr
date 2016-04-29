/**
 * Created by starn on 4/28/2016.
 */

var sequelize = require("../../config/sequelize").getSequelize;

exports.getTopRequests = function(req, res, next) {
    console.log('inside new service server controller')
    if (!req.user) {
        var  email = "john.doe@gmail.com"
        //var email = req.email_id
        var title=req.title
        var category=req.category
        var description=req.description

        // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
       /** var query = "exec dbo.sp_service :email, category, title, description";
        sequelize.query(query, { replacements: {email: email, category: category, title: title, description: description}, type: sequelize.QueryTypes.SELECT})
            .then(function(new_services) {
                console.log(JSON.stringify("exec dbo.sp_service successful"+JSON.stringify(new_services)));
                return res.json({"new_services":new_services});
            })

    } else {
        return res.status(500).send({ error: 'exec dbo.sp_service did not work'+err });
    }..*/
};