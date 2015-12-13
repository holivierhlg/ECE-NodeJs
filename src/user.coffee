db = require('./db') "#{__dirname}/../db/user"

module.exports =
  get: (username, callback) ->
    user = {}
    rs = db.createReadStream
      gte: "user:#{username}"
      lte: "user:#{username}"
    rs.on 'data', (data) ->
      console.log(data.key, '=', data.value)
      console.log "user:#{username}"
      [_, _username] = data.key.split ':' # key: user : #{username}
      [_password, _name, _email] = data.key.split ':' # value: name : password : email
      username = _username
      name = _name
      password = _password
      email = _email
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user


  save: (username, password, name, email, callback) ->


    ws = db.createWriteStream()
    ws.write({user:"#{username}", value:"#{name}:#{password}:#{email}"})
    console.log "User saved !"

    ws.on 'error', callback
    ws.on 'close', callback
    ws.end()

  remove: (username, callback) ->
