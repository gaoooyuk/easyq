// Math functions implementation in kdb+/q


/ rdiff function
/ @param x(Table|List) array
rdiff: {[x]; (deltas x)%(first x), (-1_x)};

/ general random number from normal distribution
randn: { [N]; bm each til N }
bm: { r : last {p: -1 + (2?2.0); xx::p 0; sum p*p}\[1<;2]; :xx * sqrt ((-2.0 * log r) % r) };

/ normalize function
normalize: {[x]; avg_x: avg x; var_x: var x; (x-avg_x)%(sqrt var_x)};

/ normalize function with log
/ @param x(Table|List) array
/ @param y n-based log
lnormalize: {[x;y]; avg_x: avg x; var_x: var x; y xlog ((x-avg_x)%(sqrt var_x))};

/ feature scaling function
fscaling: {[x]; max_x: max x; min_x: min x; (x-min_x)%(max_x-min_x)};