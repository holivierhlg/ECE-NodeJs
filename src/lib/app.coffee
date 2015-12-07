# nodemon src/app.coffee
express = require 'express'
app = express()

app.set 'port', 1889
app.set 'views', "#{__dirname}/../../views"
app.set 'view engine', 'jade'
app.use '/', express.static "#{__dirname}/public"
app.use require('body-parser')()

app.get '/', (req, res) ->
  res.render 'index',
    locals:
      title: 'My ECE test page'

app.get '/metrics.json', (req, res) ->
  res.status(200).JSON metrics.get()
# app.get '/login'
# app.get '/metrics'

app.get '/hello/:name', (req, res) ->
 res.status(200).send req.params.name

app.post '/metric/:id.json', (req, res) ->
  metric.save req.params.id, req.body, (err) ->
    if err then res.status(500).json err
    res.status(200).send "Metrics saved"

app.listen app.get('port'), () ->
 console.log "server listening on #{app.get 'port'}"
