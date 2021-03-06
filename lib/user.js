// Generated by CoffeeScript 1.10.0
(function() {
  var user;

  user = require('./db')(__dirname + "/../db/user");

  module.exports = {
    get: function(username, callback) {
      var rs;
      user = {};
      rs = user.createReadStream({
        gte: "user:" + username,
        lte: "user:" + username
      });
      rs.on('data', function(data) {
        var _, _email, _name, _password, _username, email, name, password, ref, ref1;
        ref = data.key.split(':'), _ = ref[0], _username = ref[1];
        ref1 = data.key.split(':'), _password = ref1[0], _name = ref1[1], _email = ref1[2];
        username = _username;
        name = _name;
        password = _password;
        return email = _email;
      });
      rs.on('error', callback);
      return rs.on('close', function() {
        return callback(null, user);
      });
    },
    save: function(username, password, name, email, callback) {},
    remove: function(username, callback) {}
  };

}).call(this);
