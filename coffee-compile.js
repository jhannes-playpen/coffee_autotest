var fs = require('fs');

var coffeeScript = process.argv[2];

fs.readFile(__dirname + '/coffee-script.js', 'utf-8', function(err, content) {
    if (err) throw err;
    eval(content.toString());	
	  fs.readFile(__dirname + '/' + coffeeScript, 'utf-8', function(e, c) {
		    if (err) throw err;
		    if (!c) {
			      console.log("Unable to load CoffeeScript file " + coffeeScript);
			      process.exit();
		    }
		    console.log(CoffeeScript.compile(c));
	  });
});
