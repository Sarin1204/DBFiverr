/**
 * Created by ramyavarakantham on 4/29/2016.
 */

var user = require('../controllers/user.server.controller'),
    passport = require('passport');

module.exports = function(app){

    app.route('/api/insertnewrequest')
        .post(user.newrequest);

    // route to test if the user is logged in or not
   
}