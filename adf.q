// Augmented Dickey-Fuller (ADF) Test function implementation in kdb+/q
// Author: Yuke Gao (chuckgao.cg@gmail.com)

/ ADF test function
/ @param ts(Table|List) price series in ascending order of time
/ @param xxx(Boolean)
/ @param lag(Int) lag order value


/ Hurst Exponent estimation using R/S analysis
/ @param ts(Table|List) log price series in ascending order of time
/ @oaram ml(Int) minimum size of a range
hurst: { [ts;ms];
	/ calculate number of ranges, and lags for each range
	nrange: floor ((count ts) % ms);
	ranges: 1 + til nrange;
	lags: {floor ((count ts) % x)} each ranges; 

	/ calculate sublists for each range
	subts: { nsublist [ts;lags[x-1];x] } each ranges;

	/ calculate all RS for all sub ranges
	rss: { {rs x} each x } each subts;

	/ calculate RS(averaged over all sub ranges) for each range
	RS: {avg x} each rss;

	/ calculate the best-fit line slope 
	slope [2 xlog lags;2 xlog RS] };

rs: { [ts];
	/ calculate mean
	mean: sum ts % count ts;

	/ calculate mean adjusted ts
	mdts: ts - mean;

	/ calculate cumulative deviate series based on mdts
	z: sums mdts;

	/ calculate range series R
	R: max z - min z;

	/ calculate std series S
	S: std ts;

	/ calculate rescaled range series R/S
	RS: R%S };

/ Split list to (most) equal chunks
nsublist: { [ts;lag;n];
	/ calculate cut indices, and partition ts to n chunks
	cuts: lag*(til n);

	cuts _ts };

stds: { [ts]; std each {x#ts} each (1+til count ts) };

std: { [ts]; mean: sum ts % count ts; sqrt (sum ((ts - mean) xexp 2) % count ts) };

slope: { [x;y];
	xMean: sum x % count x;
	yMean: sum y % count y;
	sumX: sum x;
	sumXY: sum (x*y);
	sumXX: sum (x xexp 2);
	slope: (sumXY - sumX * yMean) % (sumXX - sumX * xMean) };

