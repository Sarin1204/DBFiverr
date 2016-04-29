/**
 * Created by starn on 4/28/2016.
 */
/**
 * Created by vipul on 4/27/2016.
 */

var sequelize = require("../../config/sequelize").getSequelize;

exports.all_category = function(req, res, next) {
    console.log('inside server controller category')
    if (!req.category) {

        // var query = "exec dbo.sp_insert_person 'vipul.sarin@google.com','abcde','Vipul','Sarin'"
        var query = "SELECT category_name FROM dbo.Category";
        sequelize.query(query, {type: sequelize.QueryTypes.SELECT})
            .then(function(all_category) {
                console.log(JSON.stringify("exec retrieve from category table successful"+JSON.stringify(all_category)));

                return res.json({"all_category":all_category});
            })

    } else {
        return res.status(500).send({ error: 'retrieve category select query did not work'+err });
    }
};
