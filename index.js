var nodeq = require('node-q');
var deasync = require('deasync');

var k = null

exports.connect = function (params) {
	var done = false;
	nodeq.connect(params, function(err, con) {
		if (err) {
			console.log(err)
			throw err;
		} 

		console.log("kdb+ connected");

	    k = con
	    done = true
	});
	deasync.loopWhile(function(){return !done;});

	if (null === k) {
		return false
	}

	return true
}

exports.q = function (cmd) {
	var done = false;
	var res
    k.k(cmd, function(err, r) {
		if (err) {
			throw err
		}

		res = r
		done = true
	})
	deasync.loopWhile(function(){return !done;});

	return res
}

// Basic math functions
exports.avg = function (array) {
	var cmd = "x: " + array + "; avg x"
    return exports.q(cmd)
}

exports.cov = function (array1, array2) {
	var cmd = "cov " + "[" + array1 + "]" + " " + "[" + array2 + "]"
    return exports.q(cmd)
}
