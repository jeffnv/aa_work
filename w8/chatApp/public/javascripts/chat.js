(function(root){
  var Chatter = root.Chatter = ( root.Chatter || {} );

  var Chat = Chatter.Chat = function(socket){
    this.socket = socket;
  };

  Chat.prototype.sendMessage = function(message){
    this.socket.emit('message', {data: message});
  };
})(this);