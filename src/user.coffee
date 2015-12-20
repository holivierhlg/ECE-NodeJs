db = require('./db') "#{__dirname}/../db/user"

module.exports =
  ###
    get()
    -----
    Retrieve a specific use

    Parameters
    `username` Name of user to retrieve
    `callback` Contains an err if any
  ###
  get: (username, callback) ->
    user = null
    rs = db.createReadStream
      gte: "user:#{username}"
      lte: "user:#{username}"
    rs.on 'data', (data) ->
      key = data.key.split ":"
      value = data.value.split ":"
      user = {username : key[1], name : value[1], password : value[2], email : value[3]}
      return user
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user

  ###
    save()
    -----
    Save a new user

    Parameters
    `username` username of user to save
    `name` name of user to save
    `password` password of user to save
    `email` email of user to save
    `callback` Contains an err if any
  ###
  save: (username, name, password, email, callback) ->
    ws = db.createWriteStream()
    ws.write key: "user:#{username}", value:"user:#{name}:#{password}:#{email}"
    console.log "User saved !"

    ws.on 'error', callback
    ws.on 'close', callback
    ws.end()

  remove: (username, callback) ->
