// K-means algorithm implementation in kdb+/q


/ K-means function
/ @param data(Table|List) training data
/ @param k(Int) number of centroids
kmeans: {
	[data; k];

	$[.Q.qt[data]; data: raze each data];
	dim: mdim data;
	n_row: dim[0];
	n_col: dim[1];

	/ generate k random centroids by K-means++ algorithm
	g_ctrds data k  n_col;

	\
};

/ Returns dimensions of a matrix
mdim: { (count x; count flip x) };

g_ctrds: {
	[data; k; m];
	(k;m)#(k*m)?(til (max/)data);
};