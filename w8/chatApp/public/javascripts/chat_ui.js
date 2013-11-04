// get the message from the input form
// send the message to other users (calling the sendMessage method of the Chat object,)
// add it to the top of the display area for that userfunction .



//serialize the form,
//send the message
//add it to the display

(function(root){

  var ChatUI = root.ChatUI = (root.ChatUI || {});

  ChatUI.printMessage = function(data){
    var listItem = $('<li></li>')
    listItem.text(data.message)
   $('#convo').append(listItem)
 };

  var socket = ChatUI.socket = io.connect();
  socket.on('echo', ChatUI.printMessage);

  ChatUI.getMessage = function(event){
    event.preventDefault();
    var msg = $('#chat-input').serializeJSON();
    socket.emit("message", msg);
  };

  var submitButton = $('#chat-button');
  submitButton.on('click', ChatUI.getMessage);

})(this);
