/**
 * Created by vipul on 4/27/2016.
 */
var dashboard = require('../controllers/dashboard.server.controller');

module.exports = function(app){

    app.route('/api/getTopRequests')
        .get(dashboard.getTopRequests);

    app.route('/api/getTopServices')
        .get(dashboard.getTopServices);


}