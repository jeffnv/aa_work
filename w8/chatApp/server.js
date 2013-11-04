var http = require('http');
var path = require('path');
var mime = require('mime');
var router = require('./router').route;

var our_server = http.createServer(function (request, response) {
  router(request, response);
}).listen(8080);

var socket = require('./lib/chat_server.js')(our_server);

console.log('Server running at http://127.0.0.1:8080/');