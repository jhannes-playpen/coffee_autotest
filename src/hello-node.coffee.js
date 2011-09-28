(function() {
  var server;
  server = require('http').createServer(function(request, response) {
    response.writeHead(200, {
      'Content-Type': 'text/plain'
    });
    return response.end('Hello World');
  });
  server.listen(8124);
  console.log('Server is running at http://0.0.0.0:8124/');
}).call(this);

