# nodemon src/app.coffee
express = require 'express'
morgan = require 'morgan'
bodyparser = require 'body-parser'
session = require 'express-session'
LevelStore = require('level-session-store')(session)

app = express()

#user = require 'user'

app.set 'port', 1889
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use bodyparser.json()
app.use bodyparser.urlencoded()
app.use '/', express.static "#{__dirname}/../public"

app.use session
  secret: 'MyAppSecret'
  store: new LevelStore './db/sessions'
  resave: true
  saveUnitialized : true

authCheck = (req, res, next) ->
  unless req.session.loggedIn == true
    res.redirect '/login'
  else
    next()

app.get '/', authCheck, (req, res) ->
  res.render 'index', name: req.session.username
    locals:
      title: 'My ECE test page'

app.get '/login', (req, res)->
  res.render 'login'

app.post 'login', (req, res) ->
  user.get req.body.username, (err, data) ->
    console.log req.body.password == data.password
    if err then throw error
    unless req.body.password == data.password
      res.redirect '/login'
    else
      req.session.loggedIn =true
      req.session.username = req.body.username
      res.redirect '/'

app.get '/signup', (req, res)->
  res.render 'signup'

app.post '/signup', (req, res) ->
  user.save req.body.username, req.body.password, req.body.email, req.body.name
  if err then throw error
  unless req.body.password == data.password
    res.redirect '/signup'
  else
    req.session.loggedIn =true
    req.session.username = req.body.username
    res.redirect '/'

app.get '/metrics.json', (req, res) ->
  res.status(200).JSON metrics.get()

app.get '/hello/:name', (req, res) ->
 res.status(200).send req.params.name

app.post '/metric/:id.json', (req, res) ->
  metric.save req.params.id, req.body, (err) ->
    if err then res.status(500).json err
    res.status(200).send "Metrics saved"

app.listen app.get('port'), () ->
 console.log "server listening on #{app.get 'port'}"
