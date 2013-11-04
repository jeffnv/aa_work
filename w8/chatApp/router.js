var fs = require('fs');
var mime = require('mime');


function route(request, response){
  var filePath = request.url == "/" ? 'public/index.html' : request.url.substring(1);
  serveFile(filePath, response);
};

function serveFile(path, response){
  fs.readFile(path, function(err, data){
    console.log("loading: " + path)
    if(err) {
      serveFile('public/not-found.html', response);
    }
    else{
      // console.log(data.toString());

      // response.write(200, {"Content-Type": "text/html; charset=utf-8" });
      response.end(data);
    }
  })
}

exports.route = route;