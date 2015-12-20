db = require('./db') "#{__dirname}/../db/metrics"


module.exports =
  ###
    get()
    -----
    Returns user's personal metrics

    Parameters
    `username` User name that wishes to retrieve his metrics
    `callback` Contains an err if any
  ###

  get: (username, callback) ->
    metrics = []
    metric = []
    rs = db.createReadStream
      gte: "metrics:#{username}:1"
      lte: "metrics:#{username}:999999999999"
    rs.on 'data', (data) ->
      value = data.value.split ":"
      metric.push(timestamp: parseInt(value[1]), value: parseInt(value[2]))
      return metric

    rs.on 'error', callback

    rs.on 'close', ->
      callback null, metric

  ###
    save()
    -----
    Save a batch of user metrics

    Parameters
    `user` User to whom the metrics belong
    `m` Batch of metrics to save
    `callback` Contains an err if any
  ###
  save: (user, m, callback)->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    for metric, index in m
      {timestamp, value} = metric
      ws.write key: "metrics:#{user}:#{index+1}", value: "metrics:#{timestamp}:#{value}"
    console.log "Batch saved !"
    ws.end()

  ###
    saveNew()
    -----
    Save a new user metric

    Parameters
    `user` User that wishes to save his metrics
    `timestamp` Timestamp of metric
    `value` Value of metric
    `callback` Contains an err if any
  ###
  saveNew: (user, timestamp, value, callback)->
    this.get user, (err, data) ->
      console.log value
      ws = db.createWriteStream()
      ws.on 'error', callback
      ws.on 'close', callback
      timestampValue = new Date("#{timestamp}").getTime()
      ws.write key: "metrics:#{user}:#{data.length+1}", value: "metrics:#{timestampValue}:#{value}"
      console.log "New user metric saved !"
      ws.end()
