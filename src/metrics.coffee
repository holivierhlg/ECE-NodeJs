db = require('./db') "#{__dirname}/../db/metrics"

module.exports =
  ###
    get()
    -----
    Returns some hard coded metrics
  ###
  get: () ->
    return [
      timestamp: new Date('2015-12-01 10:30 UTC').getTime(),
      value: 26
    ,
      timestamp: new Date('2015-12-01 10:35 UTC').getTime(),
      value: 23
    ,
      timestamp: new Date('2015-12-01 10:40 UTC').getTime(),
      value: 25
    ,
      timestamp: new Date('2015-12-01 10:45 UTC').getTime(),
      value: 22
    ,
      timestamp: new Date('2015-12-01 10:50 UTC').getTime(),
      value: 21
    ,
      timestamp: new Date('2015-12-01 10:55 UTC').getTime(),
      value: 25
    ,
      timestamp: new Date('2015-12-01 11:00 UTC').getTime(),
      value: 26
    ,
      timestamp: new Date('2015-12-01 11:05 UTC').getTime(),
      value: 24
    ,
      timestamp: new Date('2015-12-01 11:10 UTC').getTime(),
      value: 22
    ,
      timestamp: new Date('2015-12-01 11:15 UTC').getTime(),
      value: 23
    ]


  ###
    save(id, metrics, cb)
    --------------------
    Save some metrics with a given id

    Parameters:

  ###
  save: (id, metrics, callback)->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    for m in metrics
      {timestamp, value} = m
      ws.write timestamp: "metrics:#{id}:#{timestamp}", value: value
    ws.end()

    ###
      remove(id, metrics, cb)
      --------------------
      Save some metrics with a given id

      Parameters:

    ###
