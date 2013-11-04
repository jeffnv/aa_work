var createChat = function(server){
  var io = require('socket.io').listen(server);
  io.sockets.on('connection', function (socket) {
    socket.emit('news', { hello: 'world' });
    socket.on('message', function (data) {
      console.log(data);
      socket.emit('echo', data);
    });
  });

}

module.exports = createChat;