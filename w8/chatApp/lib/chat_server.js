var createChat = function(server){

  var guestNumber = 0;
  var nickNames = {};
  var namesUsed = [];

  var io = require('socket.io').listen(server);
  io.sockets.on('connection', function (socket) {
    registerUser(socket);
    registerDisconnect(socket, socket.id);
    socket.on('message', function (data) {
      if (isNameRequest(data.message)) {
        handleNameRequest(data, socket);
      }
      else {
        io.sockets.emit('echo', {message: nickNames[socket.id] + ": " + data.message});
      }
    });
  });

  var handleNameRequest = function(data, socket){
    var newName = data.message.slice(6, data.message.length);
    if (namesUsed.indexOf(newName) == -1){
      changeName(socket, newName);
    }
    else{
      socket.emit('echo', {
        success: false,
        message: 'Bad choice: ' + newName
      });
    }
  };

  var registerUser = function(socket){
    guestNumber++;
    var newGuestName = "guest" + guestNumber;
    nickNames[socket.id] = newGuestName;
    namesUsed.push(newGuestName);
    io.sockets.emit('echo', {message: newGuestName + " connected"});
  };

  var isNameRequest = function(message){
    return message.slice(0, 6) === "/nick "
  };

  var changeName = function(socket, newName){
    var indx = namesUsed.indexOf(nickNames[socket.id]);
    namesUsed.splice(indx, 1);
    namesUsed.push(newName);
    nickNames[socket.id] = newName;
    socket.emit('echo', {success: true, message: 'Enjoy being called ' + newName});
  };

  var registerDisconnect = function(socket, socketID){
    socket.on('disconnect', function(){
      var name = nickNames[socketID];
      var indx = namesUsed.indexOf(name);
      namesUsed.splice(indx, 1);
      io.sockets.emit('echo', {message: name + " has disconnected!"});
      delete nickNames[socketID];
    })
  };
}

module.exports = createChat;