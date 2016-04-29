/**
 * Created by starn on 4/28/2016.
 */
var newService = require('../controllers/newService.server.controller');

module.exports = function(app){

    app.route('/api/getTopServices')
        .get(newService.getTopServices);


}