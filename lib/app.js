// Generated by CoffeeScript 1.10.0
(function() {
  var LevelStore, app, authCheck, bodyparser, express, morgan, session;

  express = require('express');

  morgan = require('morgan');

  bodyparser = require('body-parser');

  session = require('express-session');

  LevelStore = require('level-session-store')(session);

  app = express();

  app.set('port', 1889);

  app.set('views', __dirname + "/../views");

  app.set('view engine', 'jade');

  app.use(bodyparser.json());

  app.use(bodyparser.urlencoded());

  app.use('/', express["static"](__dirname + "/../public"));

  app.use(session({
    secret: 'MyAppSecret',
    store: new LevelStore('./db/sessions'),
    resave: true,
    saveUnitialized: true
  }));

  authCheck = function(req, res, next) {
    if (req.session.loggedIn !== true) {
      return res.redirect('/login');
    } else {
      return next();
    }
  };

  app.get('/', authCheck, function(req, res) {
    return res.render('index', {
      name: req.session.username({
        locals: {
          title: 'My ECE test page'
        }
      })
    });
  });

  app.get('/login', function(req, res) {
    return res.render('login');
  });

  app.post('login', function(req, res) {
    return user.get(req.body.username, function(err, data) {
      console.log(req.body.password === data.password);
      if (err) {
        throw error;
      }
      if (req.body.password !== data.password) {
        return res.redirect('/login');
      } else {
        req.session.loggedIn = true;
        req.session.username = req.body.username;
        return res.redirect('/');
      }
    });
  });

  app.get('/signup', function(req, res) {
    return res.render('signup');
  });

  app.post('/signup', function(req, res) {
    user.save(req.body.username, req.body.password, req.body.email, req.body.name);
    if (err) {
      throw error;
    }
    if (req.body.password !== data.password) {
      return res.redirect('/signup');
    } else {
      req.session.loggedIn = true;
      req.session.username = req.body.username;
      return res.redirect('/');
    }
  });

  app.get('/metrics.json', function(req, res) {
    return res.status(200).JSON(metrics.get());
  });

  app.get('/hello/:name', function(req, res) {
    return res.status(200).send(req.params.name);
  });

  app.post('/metric/:id.json', function(req, res) {
    return metric.save(req.params.id, req.body, function(err) {
      if (err) {
        res.status(500).json(err);
      }
      return res.status(200).send("Metrics saved");
    });
  });

  app.listen(app.get('port'), function() {
    return console.log("server listening on " + (app.get('port')));
  });

}).call(this);
