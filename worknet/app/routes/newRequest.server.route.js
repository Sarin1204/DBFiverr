/**
 * Created by ramyavarakantham on 4/29/2016.
 */

var newRequest = require('../controllers/newRequest.server.controller'),
    passport = require('passport');

module.exports = function(app){

    app.route('/api/insertnewrequest')
        .post(newRequest.newrequest);

    // route to test if the user is logged in or not
   
}