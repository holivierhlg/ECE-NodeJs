# nodemon src/app.coffee
express = require 'express'
morgan = require 'morgan'
bodyparser = require 'body-parser'
session = require 'express-station'
LevelStore = require('level-session-store')(session)

app = express()

user = require '/user'

app.set 'port', 1889
app.set 'views', "#{__dirname}/../../views"
app.set 'view engine', 'jade'
app.use bodyparser.json()
app.use bodyparser.urlencoded()
app.use '/', express.static "#{__dirname}/../../public"

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
