var nodeq = require('node-q');
var deasync = require('deasync');
var assert = require('assert');

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
	var cmd = "avg " + array.join(" ")
    return exports.q(cmd)
}

exports.cov = function (array1, array2) {
	var cmd = "cov " + "[" + array1 + "]" + " " + "[" + array2 + "]"
    return exports.q(cmd)
}


// Time series functions

// day-by-day change
exports.diff = function (array) {
	var cmd = "deltas " + array.join(" ")
    return exports.q(cmd)
}

// day-by-day % change
exports.rdiff = function (array) {
	var cmd = "rdiff: {[x]; (deltas x)%(first x), (-1_x)}; r: rdiff " + array.join(" ") + "; 1_r*100"
	return exports.q(cmd)
}

// Return the N-day Simple Moving Average of array
exports.sma = function (N, array) {
	assert(N <= array.length)

	var cmd = N + " mavg " + array.join(" ")
	return exports.q(cmd)
}

// Return the Exponential Moving Average of array
exports.ema = function (smooth_factor, array) {
	assert((smooth_factor > 0 && smooth_factor < 1))

	// define the ema function in q
	var cmd = "ema: {first[y](1-x)\\x*y}"
	exports.q(cmd)

	cmd = "ema " + "[" + smooth_factor + ";" + array.join(" ") + "]"
	return exports.q(cmd)
}
