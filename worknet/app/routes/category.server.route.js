/**
 * Created by starn on 4/28/2016.
 */
var category = require('../controllers/category.server.controller');

module.exports = function(app){

    app.route('/api/getCategory')
        .get(category.getCategory);


}