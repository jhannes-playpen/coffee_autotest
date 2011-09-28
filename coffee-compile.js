var fs = require('fs'),
  coffee = require('vendor/coffee-script');

var js_src = coffee.CoffeeScript.compile(fs.readFileSync(process.argv[2], "utf8"));
console.log(js_src);
