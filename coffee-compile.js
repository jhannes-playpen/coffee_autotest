var fs = require('fs'),
  coffee = require('./vendor/coffee-script');

var js_src = coffee.CoffeeScript.compile(fs.readFileSync(process.argv[2], "utf8"));
var js_file = process.argv[2].replace(/\.coffee$/, ".js")
// fs.writeFileSync(js_file, js_src, "utf8");
console.log(js_src);

