/**
 * Created by sarin on 4/23/16.
 */
var config = require('./config'),
    http = require('http'),
    express = require('express'),
    morgan = require('morgan'),
    compress = require('compression'),
    bodyParser = require('body-parser'),
    methodOverride = require('method-override'),
    session = require('express-session'),
    passport = require('passport'),
    flash = require('connect-flash')

module.exports = function () {
    var app = express();
    if (process.env.NODE_ENV === 'development') {
        app.use(morgan('dev'));
    } else if (process.env.NODE_ENV === 'production') {
        app.use(compress());
    }

    app.use(bodyParser.urlencoded({
        extended: true
    }));
    app.use(bodyParser.json());
    app.use(methodOverride());

    app.use(session({
        saveUninitialized: true,
        resave: true,
        secret: config.sessionSecret
    }));

    app.use(flash());
    app.use(passport.initialize());
    app.use(passport.session());

    app.set('views', './app/views');
    app.set('view engine', 'ejs');

    app.use(flash());
    app.use(passport.initialize());
    app.use(passport.session());

    require('../app/routes/index.server.route.js').home(app);
    require('../app/routes/signup.server.route.js')(app);
    require('../app/routes/signinPerson.server.route')(app);
    require('../app/routes/dashboard.server.route')(app);
    require('../app/routes/category.server.route')(app);
    require('../app/routes/newService.server.route')(app);
    require('../app/routes/newRequest.server.route')(app);
    //require('../app/routes/submitService.server.route')(app);
    /*require('../app/routes/signupChild.server.route.js')(app);
    require('../app/routes/signinParent.server.route.js')(app);
    require('../app/routes/findFriend.server.route.js')(app);
    require('../app/routes/postStatus.server.route.js')(app);
    require('../app/routes/dashboard.server.route.js')(app);
    require('../app/routes/profile.server.route.js')(app);
    require('../app/routes/showFriendRequests.server.route.js')(app);
    require('../app/routes/addFriend.server.route.js')(app);
    require('../app/routes/deleteFriend.server.route.js')(app);
    require('../app/routes/profileSettings.server.route.js')(app);
    require('../app/routes/search.server.route.js')(app);
    require('../app/routes/postComment.server.route.js')(app);
    require('../app/routes/cancerType.server.route.js')(app);
    require('../app/routes/interests.server.route.js')(app);
    require('../app/routes/connect.server.route.js')(app);*/

    app.use(express.static('./public'));

    return app;
}